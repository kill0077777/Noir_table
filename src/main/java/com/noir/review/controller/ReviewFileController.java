package com.noir.review.controller;

import java.io.InputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.noir.review.service.ReviewFileStorageService;

@Controller
@RequestMapping("/review/image")
public class ReviewFileController {
    @Autowired
    private ReviewFileStorageService storage;

    @RequestMapping(value="/{fileName:.+}", method=RequestMethod.GET)
    public void download(@PathVariable("fileName") String fileName,
                         HttpServletResponse response) throws Exception {
        if (!storage.exists(fileName)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        response.reset();
        response.setContentType(storage.contentType(fileName));
        response.setHeader("X-Content-Type-Options", "nosniff");
        response.setHeader("Content-Disposition", "inline; filename=\"review-image\"");
        response.setHeader("Cache-Control", "private, max-age=3600");
        response.setContentLengthLong(storage.size(fileName));

        try (InputStream input = storage.open(fileName)) {
            byte[] buffer = new byte[8192];
            int read;
            while ((read = input.read(buffer)) != -1) {
                response.getOutputStream().write(buffer, 0, read);
            }
        }
    }
}
