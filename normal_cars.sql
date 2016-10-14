-- DROP TABLE car_makes;
DROP TABLE IF EXISTS car_model;
DROP TABLE IF EXISTS car_make;
CREATE TABLE car_make (
  P_id serial NOT NULL,
  code character varying(125),
  title character varying(125),
  PRIMARY KEY (P_id)
);
CREATE TABLE car_model (
  F_id integer,
  code character varying(125),
  title character varying(125),
  year integer,
  FOREIGN KEY (F_id) REFERENCES car_make(P_id)
);

INSERT INTO car_make (code, title)
SELECT DISTINCT make_code, make_title FROM car_models ORDER BY make_title ASC;

INSERT INTO car_model (F_id, code, title, year)
SELECT DISTINCT (SELECT P_id FROM car_make WHERE title = car_models.make_title), model_code, model_title, year FROM car_models;

SELECT DISTINCT title FROM car_make;
SELECT DISTINCT title FROM car_model WHERE F_id = (SELECT P_id FROM car_make WHERE code = 'VOLKS');
--SELECT code, title, (SELECT DISTINCT code FROM car_make WHERE code = 'LAM'), year FROM car_model WHERE F_id = (SELECT P_id FROM car_make WHERE code = 'LAM');
SELECT car_model.title, car_model.code, car_model.year, car_make.code FROM car_model INNER JOIN car_make ON car_model.F_id = car_make.P_id WHERE car_make.code = 'LAM';
SELECT  car_make.code, car_make.title, car_model.title, car_model.code, car_model.year FROM car_model INNER JOIN car_make ON car_model.F_id = car_make.P_id WHERE year BETWEEN 2010 and 2015;