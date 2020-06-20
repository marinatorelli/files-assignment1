
------------------------------
-- FILM RELATED INFORMATION --
------------------------------

INSERT INTO films 
SELECT DISTINCT movie_title, director_name, duration, color, aspect_ratio, title_year, content_rating, country, language, budget, gross, facenumber_in_poster FROM old_movies;
-- 4814 rows created

INSERT INTO filmkeywords 
SELECT DISTINCT movie_title, director_name, keyword1, keyword2, keyword3, keyword4, keyword5 FROM old_movies;
-- 4814 rows created

INSERT INTO filmIMDBdata 
SELECT DISTINCT movie_title, director_name, movie_imdb_link, imdb_score, num_critic_for_reviews, num_user_for_reviews, num_voted_users FROM old_movies;
-- 4814 rows created

INSERT INTO filmgenres 
SELECT DISTINCT movie_title, director_name, genre1, genre2, genre3, genre4, genre5 FROM old_movies;
-- 4814 rows created

INSERT INTO filmcast 
SELECT DISTINCT movie_title, director_name, actor_1_name, actor_2_name, actor_3_name FROM old_movies WHERE actor_1_name IS NOT NULL;
-- 4808 rows created

INSERT INTO filmfacebookinfo 
SELECT DISTINCT movie_title, director_name, movie_facebook_likes, director_facebook_likes, actor_1_facebook_likes, actor_2_facebook_likes, actor_3_facebook_likes, cast_total_facebook_likes FROM old_movies;
-- 4814 rows created


------------------------------
-- USER-RELATED INFORMATION --
------------------------------

INSERT INTO profiles 
SELECT DISTINCT name, surname, sec_surname, age, phoneN, citizenID, birthdate FROM old_users WHERE (citizenID IS NOT NULL) AND (citizenID<>'82768894J');
-- 12064 rows created

INSERT INTO registrations 
SELECT DISTINCT nickname, passw, eMail, citizenID FROM old_users WHERE nickname IS NOT NULL AND (citizenID<>'82768894J');
-- 12064 rows created

INSERT INTO contracts 
SELECT DISTINCT contractId, citizenID, contract_type, address, ZIPcode, town, country, phoneN, to_date(startdate, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American'), to_date(enddate, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American') FROM old_users WHERE (phoneN IS NOT NULL) AND (contractID IS NOT NULL);
-- 7206 rows created


-------------------------------
-- CLUBS RELATED INFORMATION --
-------------------------------

INSERT INTO clubs (founder_username, club_name, founding_date, founding_hour, privacy, motto) 
SELECT DISTINCT client, club, to_date(ev_date, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American'), to_date(ev_hour, 'hh24:mi'), details1, subject FROM old_events WHERE Etype = 'foundation';
-- 399 rows created

INSERT INTO invitations (club_name, username, inv_date, inv_hour, emmiter) 
SELECT DISTINCT club, subject, to_date(ev_date, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American'), to_date(ev_hour, 'hh24:mi'), client FROM old_events WHERE Etype = 'invitation';
-- 5601 rows created

INSERT INTO applications (club_name, username, app_date, app_hour, message) 
SELECT DISTINCT club, client, to_date(ev_date, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American'), to_date(ev_hour, 'hh24:mi'), subject FROM old_events WHERE Etype = 'application';
-- 193 rows created

INSERT INTO proposedfilms 
SELECT DISTINCT details1, details2, club, client, to_date(ev_date, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American'), to_date(ev_hour, 'hh24:mi') FROM old_events WHERE Etype = 'proposal';
-- 15209 rows created

INSERT INTO memberships 
SELECT DISTINCT client, club, to_date(ev_date, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American') FROM old_events WHERE Etype = 'acceptance' AND NOT EXISTS (SELECT member_username FROM memberships WHERE member_username = client);
-- 4897 rows created

INSERT INTO opinions (reviewer_username, reviewer_club, op_date, op_hour, commented_film, commented_director, comment_title, comment_body) 
SELECT DISTINCT client, club, to_date(ev_date, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American'), to_date(ev_hour, 'hh24:mi'), details1, details2, subject, message FROM old_events WHERE Etype = 'opinion';
-- 5558 rows created

INSERT INTO opinions 
SELECT DISTINCT client, club, to_date(ev_date, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American'), to_date(ev_hour, 'hh24:mi'), substr(Etype, 9, 2), details1, details2, subject, message FROM old_events WHERE (Etype = 'opinion:0') OR (Etype = 'opinion:1') OR (Etype = 'opinion:2') OR (Etype = 'opinion:3') OR (Etype = 'opinion:4') OR (Etype = 'opinion:5') OR (Etype = 'opinion:6') OR (Etype = 'opinion:7') OR (Etype = 'opinion:8') OR (Etype = 'opinion:9') OR (Etype = 'opinion:10');
-- 116158 rows created

INSERT INTO history 
SELECT DISTINCT club, to_date(ev_date, 'yyyy-mm-dd', 'NLS_DATE_LANGUAGE=American'), to_date(ev_hour, 'hh24:mi') FROM old_events WHERE Etype = 'ceasing';
-- 37 rows created
