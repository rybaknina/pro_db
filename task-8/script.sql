-- 1. Провести оценку эффективности выполнения нескольких сложных запросов и
-- предложить пути решения проблемных мест, провести оптимизацию запросов.

EXPLAIN ANALYZE
SELECT video.id   AS video_id,
       first_name AS owner_first_name,
       last_name  AS owner_last_name,
       photo.url  AS photo_url,
       video.url     video_url,
       video.size    video_size
FROM users
         JOIN video
              ON video.owner_id = users.id
         JOIN profiles
              ON users.id = profiles.user_id
         JOIN photo ON photo.id = profiles.user_id
ORDER BY video_size DESC;

-- +--------------------------------------------------------------------------------------------------------------------------------+
-- |QUERY PLAN                                                                                                                      |
-- +--------------------------------------------------------------------------------------------------------------------------------+
-- |Sort  (cost=15.50..15.50 rows=2 width=1276) (actual time=0.204..0.208 rows=15 loops=1)                                          |
-- |  Sort Key: video.size DESC                                                                                                     |
-- |  Sort Method: quicksort  Memory: 27kB                                                                                          |
-- |  ->  Nested Loop  (cost=2.82..15.49 rows=2 width=1276) (actual time=0.111..0.183 rows=15 loops=1)                              |
-- |        Join Filter: (video.owner_id = photo.id)                                                                                |
-- |        ->  Hash Join  (cost=2.67..14.40 rows=2 width=772) (actual time=0.092..0.115 rows=15 loops=1)                           |
-- |              Hash Cond: (users.id = video.owner_id)                                                                            |
-- |              ->  Hash Join  (cost=1.34..12.99 rows=15 width=244) (actual time=0.042..0.057 rows=15 loops=1)                    |
-- |                    Hash Cond: (users.id = profiles.user_id)                                                                    |
-- |                    ->  Seq Scan on users  (cost=0.00..11.30 rows=130 width=240) (actual time=0.010..0.016 rows=15 loops=1)     |
-- |                    ->  Hash  (cost=1.15..1.15 rows=15 width=4) (actual time=0.020..0.021 rows=15 loops=1)                      |
-- |                          Buckets: 1024  Batches: 1  Memory Usage: 9kB                                                          |
-- |                          ->  Seq Scan on profiles  (cost=0.00..1.15 rows=15 width=4) (actual time=0.008..0.012 rows=15 loops=1)|
-- |              ->  Hash  (cost=1.15..1.15 rows=15 width=528) (actual time=0.038..0.039 rows=15 loops=1)                          |
-- |                    Buckets: 1024  Batches: 1  Memory Usage: 10kB                                                               |
-- |                    ->  Seq Scan on video  (cost=0.00..1.15 rows=15 width=528) (actual time=0.018..0.024 rows=15 loops=1)       |
-- |        ->  Index Scan using photo_pkey on photo  (cost=0.14..0.53 rows=1 width=520) (actual time=0.003..0.003 rows=1 loops=15) |
-- |              Index Cond: (id = users.id)                                                                                       |
-- |Planning Time: 0.831 ms                                                                                                         |
-- |Execution Time: 0.279 ms                                                                                                        |
-- +--------------------------------------------------------------------------------------------------------------------------------+

DROP INDEX video_owner_id_idx;
CREATE INDEX video_owner_id_idx ON video (owner_id);
DROP INDEX profiles_user_id_idx;
CREATE INDEX profiles_user_id_idx ON profiles (user_id);

-- +-----------------------------------------------------------------------------------------------------------------------------------------------------+
-- |QUERY PLAN                                                                                                                                           |
-- +-----------------------------------------------------------------------------------------------------------------------------------------------------+
-- |Sort  (cost=63.69..63.69 rows=2 width=1276) (actual time=0.197..0.199 rows=15 loops=1)                                                               |
-- |  Sort Key: video.size DESC                                                                                                                          |
-- |  Sort Method: quicksort  Memory: 27kB                                                                                                               |
-- |  ->  Nested Loop  (cost=0.56..63.68 rows=2 width=1276) (actual time=0.058..0.176 rows=15 loops=1)                                                   |
-- |        Join Filter: (video.owner_id = photo.id)                                                                                                     |
-- |        ->  Nested Loop  (cost=0.42..62.60 rows=2 width=772) (actual time=0.051..0.134 rows=15 loops=1)                                              |
-- |              Join Filter: (video.owner_id = profiles.user_id)                                                                                       |
-- |              ->  Nested Loop  (cost=0.28..58.84 rows=15 width=768) (actual time=0.040..0.088 rows=15 loops=1)                                       |
-- |                    ->  Index Scan using video_owner_id_idx on video  (cost=0.14..12.36 rows=15 width=528) (actual time=0.020..0.028 rows=15 loops=1)|
-- |                    ->  Index Scan using users_pkey on users  (cost=0.14..3.10 rows=1 width=240) (actual time=0.003..0.003 rows=1 loops=15)          |
-- |                          Index Cond: (id = video.owner_id)                                                                                          |
-- |              ->  Index Only Scan using profiles_user_id_idx on profiles  (cost=0.14..0.24 rows=1 width=4) (actual time=0.002..0.002 rows=1 loops=15)|
-- |                    Index Cond: (user_id = users.id)                                                                                                 |
-- |                    Heap Fetches: 15                                                                                                                 |
-- |        ->  Index Scan using photo_pkey on photo  (cost=0.14..0.53 rows=1 width=520) (actual time=0.002..0.002 rows=1 loops=15)                      |
-- |              Index Cond: (id = users.id)                                                                                                            |
-- |Planning Time: 0.684 ms                                                                                                                              |
-- |Execution Time: 0.255 ms                                                                                                                             |
-- +-----------------------------------------------------------------------------------------------------------------------------------------------------+


EXPLAIN ANALYZE
SELECT DISTINCT
    users.first_name,
    users.last_name,
    COUNT(messages.id) OVER (PARTITION BY users.id) AS messages_count
FROM users
         LEFT JOIN messages
                   ON users.id = messages.from_user_id
ORDER BY messages_count DESC;

-- +-----------------------------------------------------------------------------------------------------------------------------------------------------+
-- |QUERY PLAN                                                                                                                                           |
-- +-----------------------------------------------------------------------------------------------------------------------------------------------------+
-- |Unique  (cost=10000000195.08..10000000204.98 rows=990 width=248) (actual time=513.272..513.292 rows=15 loops=1)                                      |
-- |  ->  Sort  (cost=10000000195.08..10000000197.55 rows=990 width=248) (actual time=513.271..513.275 rows=20 loops=1)                                  |
-- |        Sort Key: (count(messages.id) OVER (?)) DESC, users.first_name, users.last_name                                                              |
-- |        Sort Method: quicksort  Memory: 26kB                                                                                                         |
-- |        ->  WindowAgg  (cost=10000000069.30..10000000145.82 rows=990 width=248) (actual time=513.174..513.227 rows=20 loops=1)                       |
-- |              ->  Merge Left Join  (cost=10000000069.30..10000000130.97 rows=990 width=244) (actual time=513.133..513.165 rows=20 loops=1)           |
-- |                    Merge Cond: (users.id = messages.from_user_id)                                                                                   |
-- |                    ->  Index Scan using users_pkey on users  (cost=0.14..50.09 rows=130 width=240) (actual time=513.036..513.056 rows=15 loops=1)   |
-- |                    ->  Sort  (cost=10000000069.16..10000000071.63 rows=990 width=8) (actual time=0.060..0.063 rows=15 loops=1)                      |
-- |                          Sort Key: messages.from_user_id                                                                                            |
-- |                          Sort Method: quicksort  Memory: 25kB                                                                                       |
-- |                          ->  Seq Scan on messages  (cost=10000000000.00..10000000019.90 rows=990 width=8) (actual time=0.030..0.034 rows=15 loops=1)|
-- |Planning Time: 0.548 ms                                                                                                                              |
-- |JIT:                                                                                                                                                 |
-- |  Functions: 15                                                                                                                                      |
-- |  Options: Inlining true, Optimization true, Expressions true, Deforming true                                                                        |
-- |  Timing: Generation 2.151 ms, Inlining 157.922 ms, Optimization 198.152 ms, Emission 156.965 ms, Total 515.191 ms                                   |
-- |Execution Time: 648.192 ms                                                                                                                           |
-- +-----------------------------------------------------------------------------------------------------------------------------------------------------+

DROP INDEX users_first_name_last_name_idx;
CREATE INDEX users_first_name_last_name_idx ON users (first_name, last_name);

-- +----------------------------------------------------------------------------------------------------------------------------------------------------+
-- |QUERY PLAN                                                                                                                                          |
-- +----------------------------------------------------------------------------------------------------------------------------------------------------+
-- |Unique  (cost=10000000014.58..10000000014.73 rows=15 width=25) (actual time=337.481..337.500 rows=15 loops=1)                                       |
-- |  ->  Sort  (cost=10000000014.58..10000000014.62 rows=15 width=25) (actual time=337.480..337.484 rows=20 loops=1)                                   |
-- |        Sort Key: (count(messages.id) OVER (?)) DESC, users.first_name, users.last_name                                                             |
-- |        Sort Method: quicksort  Memory: 26kB                                                                                                        |
-- |        ->  WindowAgg  (cost=10000000001.58..10000000014.29 rows=15 width=25) (actual time=337.391..337.443 rows=20 loops=1)                        |
-- |              ->  Merge Left Join  (cost=10000000001.58..10000000014.07 rows=15 width=21) (actual time=337.351..337.382 rows=20 loops=1)            |
-- |                    Merge Cond: (users.id = messages.from_user_id)                                                                                  |
-- |                    ->  Index Scan using users_pkey on users  (cost=0.14..12.36 rows=15 width=17) (actual time=337.257..337.275 rows=15 loops=1)    |
-- |                    ->  Sort  (cost=10000000001.44..10000000001.48 rows=15 width=8) (actual time=0.060..0.063 rows=15 loops=1)                      |
-- |                          Sort Key: messages.from_user_id                                                                                           |
-- |                          Sort Method: quicksort  Memory: 25kB                                                                                      |
-- |                          ->  Seq Scan on messages  (cost=10000000000.00..10000000001.15 rows=15 width=8) (actual time=0.030..0.034 rows=15 loops=1)|
-- |Planning Time: 1.133 ms                                                                                                                             |
-- |JIT:                                                                                                                                                |
-- |  Functions: 15                                                                                                                                     |
-- |  Options: Inlining true, Optimization true, Expressions true, Deforming true                                                                       |
-- |  Timing: Generation 3.103 ms, Inlining 22.006 ms, Optimization 212.217 ms, Emission 103.040 ms, Total 340.365 ms                                   |
-- |Execution Time: 340.782 ms                                                                                                                          |
-- +----------------------------------------------------------------------------------------------------------------------------------------------------+
