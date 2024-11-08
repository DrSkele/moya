CREATE EXTENSION IF NOT EXISTS postgis;

-- 기본 사용자 추가
INSERT INTO users (email, name, oauth_provider, oauth_id, profile_image_url)
VALUES ('ssafy1@naver.com', '테스트사용자1', 'oauth_provider', 'oauth_id1', 'profile_image_url');
INSERT INTO users (email, name, oauth_provider, oauth_id, profile_image_url)
VALUES ('ssafy2@naver.com', '테스트사용자2', 'oauth_provider', 'oauth_id2', 'profile_image_url');

-- Park
INSERT INTO park (name, description, image_url)
VALUES ('싸피 뒷뜰', '싸피 구미 캠퍼스 기숙사에 위치한 공원으로 봄이 되면 예쁜 꽃들이 핀답니다. 가을이 되면 감도 딸 수 있어요',
        'ssafy.jpg'),
       ('동락공원', '아름다운 낙동강을 끼고 있는 넓은 산책로와 자전거 도로를 갖춘 도심 속 힐링 공간이에요. 산책로와 잔디밭이 있어서 마음껏 뛰어놀 수 있어요.
공원에는 농구장, 축구장, 배구장, 그리고 롤러스케이트장등 여러 가지 운동 시설도 많이 있어요. 시원한 바닥분수도 있어 시원한 여름을 보낼 수 있어요.
그리고 무료로 자전거를 대여할 수 있으니 자전거 타는 것도 잊지 마세요. 신나는 동락공원을 꼭 방문해보아요!',
        'dongrac.jpg'),
       ('환경 연수원', '금오산 도립공원 구역 내에 위치하고 있는 수련 시설로 수생태체험학습장, 야외학습체험장 등등 다양한 학습 공간이 있어요.',
        'yonsuwon.jpg'),
       ('지산샛강생태공원',
        '구미의 유일한 습지인 지산샛강생태공원은 봄엔 아름다운 벚꽃산책길, 여름엔 연꽃 군락지, 겨울엔 철새 보금자리로 사계절 즐길거리가 많으며, 도심에서 가까운 곳에 위치해 있어 접근성이 좋아요. 천연기념물 큰고니의 최대 서식지로 잘 알려져있어요. 큰고니를 보고싶으면 방문해보세요.',
        'jisan-setgang.jpg');

-- Park Position
INSERT INTO park_pos (pos, park_id, name)
VALUES (ST_SetSRID(ST_MakePoint(128.410590, 36.107442), 4326), 1, '정문'),
       (ST_SetSRID(ST_MakePoint(128.417373, 36.107535), 4326), 1, '후문'),
       (ST_SetSRID(ST_MakePoint(128.416504, 36.105738), 4326), 1, '개구멍'),
       (ST_SetSRID(ST_MakePoint(128.402023, 36.104893), 4326), 2, '북쪽 입구'),
       (ST_SetSRID(ST_MakePoint(128.401838, 36.101802), 4326), 2, '1 주차장'),
       (ST_SetSRID(ST_MakePoint(128.402133, 36.098217), 4326), 2, '중간 입구 1'),
       (ST_SetSRID(ST_MakePoint(128.402455, 36.096804), 4326), 2, '중간 입구 2'),
       (ST_SetSRID(ST_MakePoint(128.403072, 36.093575), 4326), 2, '4 주차장'),
       (ST_SetSRID(ST_MakePoint(128.403209, 36.092183), 4326), 2, '중간 입구'),
       (ST_SetSRID(ST_MakePoint(128.403233, 36.091906), 4326), 2, '5 주차장'),
       (ST_SetSRID(ST_MakePoint(128.402881, 36.089234), 4326), 2, '중간 입구'),
       (ST_SetSRID(ST_MakePoint(128.402859, 36.089024), 4326), 2, '6 주차장'),
       (ST_SetSRID(ST_MakePoint(128.400617, 36.085257), 4326), 2, '아래 입구'),
       (ST_SetSRID(ST_MakePoint(128.399493, 36.084151), 4326), 2, '7 주차장'),
       (ST_SetSRID(ST_MakePoint(128.398673, 36.083426), 4326), 2, '젤 아래 입구'),
       (ST_SetSRID(ST_MakePoint(128.311031, 36.119622), 4326), 3, '환경 연수원 입구'),
       (ST_SetSRID(ST_MakePoint(128.352066, 36.137240), 4326), 4, '지산샛강 생태공원 입구');

-- NPC
INSERT INTO npc (name)
VALUES ('수달'), ('검사 수달'), ('기도하는 수달'), ('너구리'), ('마법사 너구리'),
       ('병아리'), ('거북이'), ('갈색 거북이'), ('토끼'), ('이정표'),
       ('펭귄'), ('돛새치');

-- Park NPCs
INSERT INTO park_npc (park_id, npc_id)
VALUES (1, 9), (1, 3), (1, 11),
       (2, 3), (2, 4), (2, 8), (2, 11),
       (3, 5), (3, 6), (3, 9), (3, 12);

-- NPC Position
INSERT INTO npc_pos (pos, park_npc_id)
VALUES (ST_SetSRID(ST_MakePoint(128.41666183811466, 36.10694581886462), 4326), 1),
       (ST_SetSRID(ST_MakePoint(128.41629035007824, 36.10680367153273), 4326), 2),
       (ST_SetSRID(ST_MakePoint(128.41606821959087, 36.10658568817424), 4326), 3),
       (ST_SetSRID(ST_MakePoint(128.402000, 36.100000), 4326), 5),
       (ST_SetSRID(ST_MakePoint(128.402500, 36.095000), 4326), 6),
       (ST_SetSRID(ST_MakePoint(128.311500, 36.119000), 4326), 9);

-- Species
INSERT INTO species (name, scientific_name, description, image_url)
VALUES ('강아지풀', 'Setaria viridis', '강아지 꼬리처럼 복슬복슬 귀여운 강아지풀', 'foxtail.jpg'),
       ('단풍잎', 'Acer palmatum', '가을이 되면 물드는 단풍잎', 'maple-leaves.jpg'),
       ('솔방울', 'Pinus densiflora Siebold & Zucc', '씨앗이 들어있는 자그마한 비늘들이 둥글게 모인 소나무 열매의 송이', 'pine-cones.jpg'),
       ('란타나', 'Lantana camara', '다양한 색깔의 꽃을 피우는 관목', 'lantana.jpg'),
       ('히비스커스', 'Hibiscus rosa-sinensis', '큰 꽃을 피우는 열대성 식물', 'hibiscus.jpg'),
       ('야트로파 쿠르카스', 'Jatropha curcas', '고소한 향을 가진 꽃을 피우는 나무', 'jatropha-curcas.jpg'),
       ('마리골드', 'Tagetes erecta', '주황색 꽃을 피우는 한해살이 식물', 'marigold.jpg'),
       ('장미', 'Rosa', '전 세계적으로 사랑받는 꽃으로 다양한 품종이 존재', 'rose.jpg'),
       ('참파카초령목', 'Magnolia champaca', '향기로운 꽃을 피우는 나무', 'champaca.jpg'),
       ('백화단', 'Plumbago zeylanica', '작은 흰색 꽃을 피우는 관목', 'plumbago-zeylanica.jpg'),
       ('인동덩굴', 'Lonicera', '달콤한 향을 가진 덩굴식물', 'lonicera.jpg'),
       ('아부틸론 인디쿰', 'Abutilon indicum', '작은 노란 꽃을 피우는 식물', 'abutilon-indicum.jpg'),
       ('야모란과', 'Melastoma malabathricum', '보라색 꽃을 피우는 관목', 'melastoma-malabathricum.jpg'),
       ('버터플라이피', 'Clitoria ternatea', '파란색 꽃을 피우는 덩굴식물', 'clitoria-ternatea.jpg'),
       ('히메노칼리스', 'Hymenocallis littoralis', '거미 모양의 꽃을 피우는 식물', 'hymenocallis-littoralis.jpg'),
       ('해바라기', 'Helianthus annuus', '커다란 노란 꽃을 피우는 식물', 'sunflowers.jpg'),
       ('나비', 'butterfly', '다양한 색과 모양을 가진 아름다운 날개를 펼치며 꽃가루를 모으는 곤충', 'butterfly.jpg'),
       ('잠자리', 'dragonfly', '빠른 비행과 날렵한 체형을 가진 곤충으로 주로 습지나 물가에서 볼 수 있음', 'dragonfly.jpg'),
       ('사슴벌레', 'stag beetle', '커다란 뿔과 강력한 턱을 가진 곤충으로, 주로 숲 속에서 서식', 'stag-beetle.jpg');

-- 동식물의 볼 수 있는 계절 정보 삽입
INSERT INTO species_seasons (species_id, season)
VALUES (1, 'SPRING'), (1, 'SUMMER'),
       (2, 'AUTUMN'),
       (3, 'SPRING'), (3, 'SUMMER'), (3, 'AUTUMN'),
       (4, 'SPRING'), (4, 'SUMMER'), (4, 'AUTUMN'),
       (5, 'SPRING'), (5, 'SUMMER'), (5, 'AUTUMN'),
       (6, 'SPRING'), (6, 'SUMMER'),
       (7, 'SPRING'), (7, 'SUMMER'), (7, 'AUTUMN'),
       (8, 'SPRING'), (8, 'SUMMER'), (8, 'AUTUMN'), (8, 'WINTER'),
       (9, 'SPRING'), (9, 'SUMMER'),
       (10, 'SPRING'), (10, 'SUMMER'),
       (11, 'SPRING'),
       (12, 'SPRING'), (12, 'SUMMER'),
       (13, 'SPRING'), (13, 'SUMMER'), (13, 'AUTUMN'),
       (14, 'SUMMER'), (14, 'AUTUMN'),
       (15, 'SUMMER'), (15, 'AUTUMN'),
       (16, 'SUMMER'), (16, 'AUTUMN');

-- Park Species
INSERT INTO park_species (park_id, species_id)
VALUES (1, 1), (1, 2), (1, 3),
       (2, 1), (2, 2), (2, 3), (2, 8), (2, 16),
       (3, 1), (3, 2), (3, 3), (3, 8), (3, 16)
ON CONFLICT (park_id, species_id) DO NOTHING;

-- Species Position
INSERT INTO species_pos (pos, park_species_id)
VALUES
    -- 싸피 뒷뜰 - 강아지풀
    (ST_SetSRID(ST_MakePoint(128.41661650107773, 36.10723183051107), 4326), 1),
    (ST_SetSRID(ST_MakePoint(128.41669466701717, 36.10724854271623), 4326), 1),
    -- 싸피 뒷뜰 - 단풍잎
    (ST_SetSRID(ST_MakePoint(128.41616260682056, 36.107314657987054), 4326), 2),
    (ST_SetSRID(ST_MakePoint(128.4162997739545, 36.10731883716082), 4326), 2),
    (ST_SetSRID(ST_MakePoint(128.41657472637084, 36.10725594643574), 4326), 2),
    -- 싸피 뒷뜰 - 솔방울
    (ST_SetSRID(ST_MakePoint(128.41572843945207, 36.10693981063123), 4326), 3),
    (ST_SetSRID(ST_MakePoint(128.41572810023425, 36.10698590544886), 4326), 3),
    (ST_SetSRID(ST_MakePoint(128.41576341821207, 36.10721037389451), 4326), 3);

-- Quest
INSERT INTO quest (type)
VALUES (1), (2), (3);

-- Exploration Data Insertion
INSERT INTO exploration (user_id, park_id, start_time, end_time, distance, steps, startdate,
                         image_url, route, completed)
VALUES (1, 1, '2024-09-23 10:00:00', '2024-09-23 12:00:00', 2500, 5000, '2024-09-23',
        'test-camera.png',
        ST_GeomFromText('LINESTRING(128.416000 36.107000, 128.416100 36.107100, 128.416200 36.107200)', 4326),
        true),
       (1, 2, '2024-09-24 09:00:00', '2024-09-24 11:30:00', 5000, 8000, '2024-09-24',
        'test-camera.png',
        ST_GeomFromText('LINESTRING(128.402000 36.100000, 128.402100 36.100100, 128.402500 36.095000)', 4326),
        true),
       (1, 3, '2024-09-25 14:00:00', '2024-09-25 16:00:00', 3000, 6000, '2024-09-25',
        'test-camera.png',
        ST_GeomFromText('LINESTRING(128.311500 36.119000, 128.311600 36.119100, 128.312000 36.120000)', 4326),
        true);

-- Discovery Data Insertion
-- 강아지풀 발견 데이터
INSERT INTO discovery (user_id, species_id, species_pos_id, discovery_time, image_url)
SELECT 1, 1, sp.id, '2024-09-23 11:00:00', 'test-camera.png'
FROM species_pos sp
         JOIN park_species ps ON ps.id = sp.park_species_id
WHERE ps.park_id = 1 AND ps.species_id = 1
  AND ST_Equals(sp.pos, ST_SetSRID(ST_MakePoint(128.416200, 36.107200), 4326));

-- 단풍잎 발견 데이터
INSERT INTO discovery (user_id, species_id, species_pos_id, discovery_time, image_url)
SELECT 1, 2, sp.id, '2024-09-23 10:30:00', 'test-camera.png'
FROM species_pos sp
         JOIN park_species ps ON ps.id = sp.park_species_id
WHERE ps.park_id = 1 AND ps.species_id = 2
  AND ST_Equals(sp.pos, ST_SetSRID(ST_MakePoint(128.416000, 36.107000), 4326));

-- 솔방울 발견 데이터
INSERT INTO discovery (user_id, species_id, species_pos_id, discovery_time, image_url)
SELECT 1, 3, sp.id, '2024-09-24 10:15:00', 'test-camera.png'
FROM species_pos sp
         JOIN park_species ps ON ps.id = sp.park_species_id
WHERE ps.park_id = 2 AND ps.species_id = 3
  AND ST_Equals(sp.pos, ST_SetSRID(ST_MakePoint(128.402500, 36.095000), 4326));

-- 장미 발견 데이터
INSERT INTO discovery (user_id, species_id, species_pos_id, discovery_time, image_url)
SELECT 1, 8, sp.id, '2024-09-24 11:00:00', 'test-camera.png'
FROM species_pos sp
         JOIN park_species ps ON ps.id = sp.park_species_id
WHERE ps.park_id = 2 AND ps.species_id = 8
  AND ST_Equals(sp.pos, ST_SetSRID(ST_MakePoint(128.403000, 36.090000), 4326));

-- 해바라기 발견 데이터
INSERT INTO discovery (user_id, species_id, species_pos_id, discovery_time, image_url)
SELECT 1, 16, sp.id, '2024-09-25 15:00:00', 'test-camera.png'
FROM species_pos sp
         JOIN park_species ps ON ps.id = sp.park_species_id
WHERE ps.park_id = 3 AND ps.species_id = 16
  AND ST_Equals(sp.pos, ST_SetSRID(ST_MakePoint(128.312000, 36.120000), 4326));

-- 테스트용 공원 20개 추가
INSERT INTO park (name, description, image_url)
VALUES
    ('푸른 숲 공원', '푸른 나무들이 가득한 공원입니다.', 'park1.jpg'),
    ('햇살 가득한 정원', '따뜻한 햇살이 비치는 공원입니다.', 'park2.jpg'),
    ('꽃내음 정원', '다양한 꽃들이 만발한 향기로운 공원입니다.', 'park3.jpg'),
    ('맑은 호수 공원', '맑은 호수를 끼고 있는 아름다운 공원입니다.', 'park4.jpg'),
    ('바람길 산책로', '시원한 바람이 불어오는 산책로입니다.', 'park5.jpg'),
    ('별빛 공원', '밤에는 별이 잘 보이는 공원입니다.', 'park6.jpg'),
    ('조용한 숲길', '산책하며 여유를 즐길 수 있는 조용한 숲길입니다.', 'park7.jpg'),
    ('강변 공원', '강을 따라 걸을 수 있는 산책로가 있는 공원입니다.', 'park8.jpg'),
    ('햇빛마루 공원', '햇빛이 잘 드는 공간에서 여유를 즐길 수 있는 공원입니다.', 'park9.jpg'),
    ('솔향기 공원', '솔향기가 가득한 소나무 숲 공원입니다.', 'park10.jpg'),
    ('자연 생태원', '다양한 동식물을 만날 수 있는 자연 생태 공원입니다.', 'park11.jpg'),
    ('바람숲 정원', '산들바람이 불어오는 정원입니다.', 'park12.jpg'),
    ('햇살숲 공원', '따뜻한 햇살을 느낄 수 있는 나무숲 공원입니다.', 'park13.jpg'),
    ('물빛 정원', '작은 연못과 물길이 흐르는 정원입니다.', 'park14.jpg'),
    ('푸른 언덕 공원', '푸른 언덕을 오르며 자연을 느낄 수 있는 공원입니다.', 'park15.jpg'),
    ('평화의 숲길', '평온한 분위기 속에서 산책할 수 있는 숲길입니다.', 'park16.jpg'),
    ('새벽공원', '새벽에 가장 아름다운 풍경을 볼 수 있는 공원입니다.', 'park17.jpg'),
    ('달빛 공원', '밤에는 달빛이 비치는 낭만적인 공원입니다.', 'park18.jpg'),
    ('잔디밭 공원', '넓은 잔디밭에서 여유를 즐길 수 있는 공원입니다.', 'park19.jpg'),
    ('호숫가 산책로', '호숫가를 따라 걸을 수 있는 산책로가 있는 공원입니다.', 'park20.jpg');

-- 테스트용 공원 위치 추가
INSERT INTO park_pos (pos, park_id, name)
SELECT ST_SetSRID(
               ST_MakePoint(
                       128.416431 + (random() - 0.5) * 0.7,
                       36.108044 + (random() - 0.5) * 0.7
               ),
               4326
       ),
       p.id,
       '입구'
FROM park p
WHERE p.name IN (
                 '푸른 숲 공원', '햇살 가득한 정원', '꽃내음 정원',
                 '맑은 호수 공원', '바람길 산책로', '별빛 공원',
                 '조용한 숲길', '강변 공원', '햇빛마루 공원',
                 '솔향기 공원', '자연 생태원', '바람숲 정원',
                 '햇살숲 공원', '물빛 정원', '푸른 언덕 공원',
                 '평화의 숲길', '새벽공원', '달빛 공원',
                 '잔디밭 공원', '호숫가 산책로'
    )
ORDER BY p.id;