-- 리뷰-예약 관계를 customer_id에서 고유 reserve_id로 전환합니다.
-- 운영 적용 전 아래 조회로 다중 예약 고객의 기존 리뷰를 수동 매핑하십시오.

ALTER TABLE noir_review ADD (reserve_id NUMBER);

-- 고객당 예약이 정확히 1건인 레거시 리뷰만 자동 매핑합니다.
UPDATE noir_review r
SET r.reserve_id = (
    SELECT MIN(cr.reserve_id)
    FROM customer_reservation cr
    WHERE cr.customer_id = r.customer_id
    GROUP BY cr.customer_id
    HAVING COUNT(*) = 1
)
WHERE r.reserve_id IS NULL;

-- 자동 매핑되지 않은 레거시 리뷰 확인
SELECT r.review_id, r.customer_id
FROM noir_review r
WHERE r.reserve_id IS NULL;

-- 위 결과를 수동 매핑하고 중복/NULL이 없는 것을 확인한 뒤 실행합니다.
-- ALTER TABLE noir_review MODIFY (reserve_id NOT NULL);
-- ALTER TABLE noir_review ADD CONSTRAINT fk_review_reserve
--     FOREIGN KEY (reserve_id) REFERENCES customer_reservation (reserve_id);
-- ALTER TABLE noir_review ADD CONSTRAINT uk_review_reserve UNIQUE (reserve_id);

-- 신규 입력의 별점 범위도 DB에서 보장합니다.
ALTER TABLE noir_review ADD CONSTRAINT ck_review_rating CHECK (rating BETWEEN 1 AND 5);
