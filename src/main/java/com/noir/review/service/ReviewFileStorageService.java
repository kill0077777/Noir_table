package com.noir.review.service;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Locale;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ReviewFileStorageService {
    private static final long MAX_BYTES = 5L * 1024L * 1024L;
    private final Path root;

    public ReviewFileStorageService() {
        String configured = System.getProperty("noir.upload.review.dir");
        if (configured == null || configured.trim().isEmpty()) {
            configured = System.getenv("NOIR_REVIEW_UPLOAD_DIR");
        }
        if (configured == null || configured.trim().isEmpty()) {
            configured = "/var/lib/noir/uploads/review";
        }
        this.root = Paths.get(configured).toAbsolutePath().normalize();
    }

    public String store(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) return null;
        if (file.getSize() > MAX_BYTES) throw new IOException("리뷰 이미지 크기 제한 초과");

        String original = file.getOriginalFilename();
        String extension = extensionOf(original);
        if (!("jpg".equals(extension) || "jpeg".equals(extension) || "png".equals(extension))) {
            throw new IOException("JPG, JPEG, PNG 이미지만 업로드할 수 있습니다.");
        }

        // MIME 헤더나 확장자만 믿지 않고 실제 이미지 디코딩을 수행합니다.
        try (InputStream input = file.getInputStream()) {
            BufferedImage image = ImageIO.read(input);
            if (image == null || image.getWidth() <= 0 || image.getHeight() <= 0
                    || image.getWidth() > 8000 || image.getHeight() > 8000) {
                throw new IOException("유효하지 않은 이미지입니다.");
            }
        }

        Files.createDirectories(root);
        String storedName = UUID.randomUUID().toString() + "." + extension;
        Path target = resolveSafe(storedName);
        file.transferTo(target.toFile());
        return storedName;
    }

    public InputStream open(String storedName) throws IOException {
        return Files.newInputStream(resolveSafe(storedName));
    }

    public long size(String storedName) throws IOException {
        return Files.size(resolveSafe(storedName));
    }

    public boolean exists(String storedName) throws IOException {
        return Files.exists(resolveSafe(storedName));
    }

    public void delete(String storedName) throws IOException {
        if (storedName == null || storedName.trim().isEmpty()) return;
        Files.deleteIfExists(resolveSafe(storedName));
    }

    public String contentType(String storedName) {
        String extension = extensionOf(storedName);
        if ("jpg".equals(extension) || "jpeg".equals(extension)) return "image/jpeg";
        if ("png".equals(extension)) return "image/png";
        return "application/octet-stream";
    }

    private Path resolveSafe(String storedName) throws IOException {
        if (storedName == null || !storedName.matches("[a-f0-9-]{36}\\.(jpg|jpeg|png)")) {
            throw new IOException("잘못된 파일명");
        }
        Path resolved = root.resolve(storedName).normalize();
        if (!resolved.startsWith(root)) throw new IOException("잘못된 파일 경로");
        return resolved;
    }

    private String extensionOf(String filename) {
        if (filename == null) return "";
        int dot = filename.lastIndexOf('.');
        if (dot < 0 || dot == filename.length() - 1) return "";
        return filename.substring(dot + 1).toLowerCase(Locale.ROOT);
    }
}
