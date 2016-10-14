-- DROP TABLE car_makes;
DROP TABLE IF EXISTS years;
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
  model_id serial NOT NULL,
  code character varying(125),
  title character varying(125),
  PRIMARY KEY (model_id),
  FOREIGN KEY (F_id) REFERENCES car_make(P_id)
);
CREATE TABLE years (
  M_id integer,
  year integer,
  FOREIGN KEY (M_id) REFERENCES car_model(model_id)
);

INSERT INTO car_make (code, title)
SELECT DISTINCT make_code, make_title FROM car_models ORDER BY make_title ASC;

INSERT INTO car_model (F_id, code, title)
SELECT DISTINCT (SELECT P_id FROM car_make WHERE title = car_models.make_title), model_code, model_title FROM car_models;

INSERT INTO years (M_id, year)
SELECT (SELECT model_id FROM car_model WHERE code = 'GT-R'), year FROM car_models;

-- SELECT DISTINCT make_title FROM car_models;
