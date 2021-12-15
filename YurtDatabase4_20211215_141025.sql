--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: kapasite(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kapasite() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF ((SELECT COUNT(*) FROM "Ogrenci" WHERE "odaNo" = NEW."odaNo")>3)
    THEN
            RAISE EXCEPTION 'Bu odanin kapasitesi dolu!';  
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.kapasite() OWNER TO postgres;

--
-- Name: kurskapasite(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kurskapasite() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF ((SELECT COUNT(*) FROM "Kayit" WHERE "kursNo" = NEW."kursNo")>9)
    THEN
        RAISE EXCEPTION 'Kursun kapasitesi dolu! Yeni ogrenci eklenemez!';  
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.kurskapasite() OWNER TO postgres;

--
-- Name: kurskayit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kurskayit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 

kayitTarihi DATE := CURRENT_DATE;
 
BEGIN

INSERT INTO "Kayit"("ogrenciNo","kursNo","kayitTarihi")
VALUES (NEW."ogrenciNo",NEW."kursNo",kayitTarihi);
RETURN NEW;
END 
$$;


ALTER FUNCTION public.kurskayit() OWNER TO postgres;

--
-- Name: ogrenciara(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrenciara(ogrencino character varying) RETURNS TABLE(adi character varying, soyadi character varying, kursno integer, odano integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "ad", "soyad", "kursNo", "odaNo" FROM "Ogrenci"
                 WHERE "ogrenciNo" = ogrenciNo;
END;
$$;


ALTER FUNCTION public.ogrenciara(ogrencino character varying) OWNER TO postgres;

--
-- Name: ogrenciekle(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrenciekle(ogrencino character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$

BEGIN

DELETE FROM "Ogrenci" WHERE "ogrenciNo"==ogrenciNo;

END 
$$;


ALTER FUNCTION public.ogrenciekle(ogrencino character varying) OWNER TO postgres;

--
-- Name: ogrenciekle(character varying, character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrenciekle(ogrencino character varying, adi character varying, soyadi character varying, odano integer, kursno integer) RETURNS void
    LANGUAGE plpgsql
    AS $$

BEGIN

INSERT INTO "Ogrenci"("ogrenciNo","ad","soyad","odaNo","kursNo")
VALUES (ogrenciNo,adi,soyadi,odaNo,kursNo);

END 
$$;


ALTER FUNCTION public.ogrenciekle(ogrencino character varying, adi character varying, soyadi character varying, odano integer, kursno integer) OWNER TO postgres;

--
-- Name: ogrenciguncelle(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrenciguncelle(ogrencino character varying, kursno integer) RETURNS void
    LANGUAGE plpgsql
    AS $$

BEGIN

UPDATE "Ogrenci"
SET "kursNo" = kursNo 
WHERE "ogrenciNo" = ogrenciNo;

END 
$$;


ALTER FUNCTION public.ogrenciguncelle(ogrencino character varying, kursno integer) OWNER TO postgres;

--
-- Name: ogrencisil(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrencisil(ogrencino character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$

BEGIN

DELETE FROM "Ogrenci" WHERE "ogrenciNo"=ogrenciNo;

END 
$$;


ALTER FUNCTION public.ogrencisil(ogrencino character varying) OWNER TO postgres;

--
-- Name: yurtkapasite(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yurtkapasite() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF ((SELECT COUNT(*) FROM "Ogrenci")>100)
    THEN
            RAISE EXCEPTION 'Yurdun kapasitesi dolu! Yeni ogrenci eklenemez!';  
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.yurtkapasite() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Bina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bina" (
    "binaNo" integer NOT NULL,
    "yurtNo" integer NOT NULL
);


ALTER TABLE public."Bina" OWNER TO postgres;

--
-- Name: Dil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dil" (
    "kursNo" integer NOT NULL
);


ALTER TABLE public."Dil" OWNER TO postgres;

--
-- Name: Egitmen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Egitmen" (
    "personelNo" integer NOT NULL,
    "etutNo" integer NOT NULL
);


ALTER TABLE public."Egitmen" OWNER TO postgres;

--
-- Name: EtutSalonu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EtutSalonu" (
    "etutNo" integer NOT NULL,
    "binaNo" integer NOT NULL
);


ALTER TABLE public."EtutSalonu" OWNER TO postgres;

--
-- Name: Guvenlik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Guvenlik" (
    "personelNo" integer NOT NULL,
    "binaNo" integer NOT NULL
);


ALTER TABLE public."Guvenlik" OWNER TO postgres;

--
-- Name: Hademe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Hademe" (
    "personelNo" integer NOT NULL,
    "binaNo" integer NOT NULL
);


ALTER TABLE public."Hademe" OWNER TO postgres;

--
-- Name: Kayit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kayit" (
    "ogrenciNo" character(10) NOT NULL,
    "kursNo" integer NOT NULL,
    "kayitTarihi" date NOT NULL,
    "kayitNo" real NOT NULL
);


ALTER TABLE public."Kayit" OWNER TO postgres;

--
-- Name: Kurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kurs" (
    "kursNo" integer NOT NULL,
    "kursAdi" character varying(40) NOT NULL,
    "etutNo" integer NOT NULL,
    "yurtNo" integer NOT NULL
);


ALTER TABLE public."Kurs" OWNER TO postgres;

--
-- Name: Muzik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Muzik" (
    "kursNo" integer NOT NULL
);


ALTER TABLE public."Muzik" OWNER TO postgres;

--
-- Name: Oda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Oda" (
    "odaNo" integer NOT NULL,
    "binaNo" integer NOT NULL
);


ALTER TABLE public."Oda" OWNER TO postgres;

--
-- Name: Ogrenci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ogrenci" (
    "ogrenciNo" character(10) NOT NULL,
    "odaNo" integer NOT NULL,
    ad character varying(40) NOT NULL,
    soyad character varying(40) NOT NULL,
    "kursNo" integer
);


ALTER TABLE public."Ogrenci" OWNER TO postgres;

--
-- Name: Personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Personel" (
    "personelNo" integer NOT NULL,
    ad character varying(40) NOT NULL,
    soyad character varying(40) NOT NULL,
    "yurtNo" integer NOT NULL
);


ALTER TABLE public."Personel" OWNER TO postgres;

--
-- Name: Yazilim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yazilim" (
    "kursNo" integer NOT NULL
);


ALTER TABLE public."Yazilim" OWNER TO postgres;

--
-- Name: Yonetici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yonetici" (
    "personelNo" integer NOT NULL,
    "binaNo" integer NOT NULL
);


ALTER TABLE public."Yonetici" OWNER TO postgres;

--
-- Name: Yurt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yurt" (
    "yurtNo" integer NOT NULL,
    ad character varying(40) NOT NULL
);


ALTER TABLE public."Yurt" OWNER TO postgres;

--
-- Name: serial; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.serial OWNER TO postgres;

--
-- Name: serial; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serial OWNED BY public."Kayit"."kayitNo";


--
-- Name: Kayit kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kayit" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public.serial'::regclass);


--
-- Data for Name: Bina; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Bina" ("binaNo", "yurtNo") VALUES
	(1, 1);


--
-- Data for Name: Dil; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Egitmen; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: EtutSalonu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."EtutSalonu" ("etutNo", "binaNo") VALUES
	(1, 1);


--
-- Data for Name: Guvenlik; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Hademe; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Kayit; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kayit" ("ogrenciNo", "kursNo", "kayitTarihi", "kayitNo") VALUES
	('g891313212', 1, '2021-12-15', 18),
	('g203892212', 1, '2021-12-15', 19),
	('g328783321', 1, '2021-12-15', 21),
	('g213931672', 1, '2021-12-15', 22),
	('g323891321', 1, '2021-12-15', 23),
	('g891023212', 1, '2021-12-15', 27),
	('g200192212', 1, '2021-12-15', 28),
	('g971311612', 1, '2021-12-15', 29),
	('g328123321', 1, '2021-12-15', 30),
	('g305491321', 1, '2021-12-15', 32);


--
-- Data for Name: Kurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kurs" ("kursNo", "kursAdi", "etutNo", "yurtNo") VALUES
	(1, 'Yazilim', 1, 1),
	(2, 'Dil', 1, 1),
	(3, 'Muzik', 1, 1);


--
-- Data for Name: Muzik; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Oda; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Oda" ("odaNo", "binaNo") VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1);


--
-- Data for Name: Ogrenci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ogrenci" ("ogrenciNo", "odaNo", ad, soyad, "kursNo") VALUES
	('g891313212', 4, 'Kaan', 'Yilmaz', 1),
	('g203892212', 4, 'Kaan', 'Yilmaz', 1),
	('g328783321', 5, 'Kaan', 'Yilmaz', 1),
	('g213931672', 5, 'Kaan', 'Yilmaz', 1),
	('g323891321', 5, 'Kaan', 'Yilmaz', 1),
	('g891023212', 1, 'Kaan', 'Yilmaz', 1),
	('g200192212', 1, 'Kaan', 'Yilmaz', 1),
	('g971311612', 2, 'Kaan', 'Yilmaz', 1),
	('g328123321', 2, 'Kaan', 'Yilmaz', 1),
	('g211301672', 4, 'Kaan', 'Yilmaz', 1),
	('g305491321', 5, 'Kaan', 'Yilmaz', 1),
	('g201320003', 2, 'Kerem', 'Noone', 1),
	('g201010003', 1, 'Ahmet', 'Noone', 1),
	('g201312002', 3, 'Kaan', 'Yilmaz', 1),
	('g201312012', 3, 'Kaan', 'Yilmaz', 1),
	('g201311012', 3, 'Kaan', 'Yilmaz', 1),
	('g201312212', 3, 'Kaan', 'Yilmaz', 1),
	('g201311612', 2, 'Kaan', 'Yilmaz', 1),
	('g201210003', 1, 'Abdurrahman', 'Alpturan', 1),
	('g201313212', 4, 'Kaan', 'Yilmaz', 1);


--
-- Data for Name: Personel; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Yazilim; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Yonetici; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Yurt; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yurt" ("yurtNo", ad) VALUES
	(1, 'MFS Yurdu');


--
-- Name: serial; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serial', 33, true);


--
-- Name: Bina binaPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bina"
    ADD CONSTRAINT "binaPK" PRIMARY KEY ("binaNo");


--
-- Name: Dil dilNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dil"
    ADD CONSTRAINT "dilNo" PRIMARY KEY ("kursNo");


--
-- Name: Egitmen egitmenPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Egitmen"
    ADD CONSTRAINT "egitmenPK" PRIMARY KEY ("personelNo");


--
-- Name: EtutSalonu etutPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EtutSalonu"
    ADD CONSTRAINT "etutPK" PRIMARY KEY ("etutNo");


--
-- Name: Guvenlik guvenlikPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Guvenlik"
    ADD CONSTRAINT "guvenlikPK" PRIMARY KEY ("personelNo");


--
-- Name: Hademe hademePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hademe"
    ADD CONSTRAINT "hademePK" PRIMARY KEY ("personelNo");


--
-- Name: Kayit kayitPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kayit"
    ADD CONSTRAINT "kayitPK" PRIMARY KEY ("kayitNo");


--
-- Name: Kurs kursPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kurs"
    ADD CONSTRAINT "kursPK" PRIMARY KEY ("kursNo");


--
-- Name: Muzik muzikNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Muzik"
    ADD CONSTRAINT "muzikNo" PRIMARY KEY ("kursNo");


--
-- Name: Oda odaPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Oda"
    ADD CONSTRAINT "odaPK" PRIMARY KEY ("odaNo");


--
-- Name: Ogrenci ogrenciPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "ogrenciPK" PRIMARY KEY ("ogrenciNo");


--
-- Name: Personel personelPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "personelPK" PRIMARY KEY ("personelNo");


--
-- Name: Yazilim yazilimPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazilim"
    ADD CONSTRAINT "yazilimPK" PRIMARY KEY ("kursNo");


--
-- Name: Yonetici yoneticiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetici"
    ADD CONSTRAINT "yoneticiPK" PRIMARY KEY ("personelNo");


--
-- Name: Yurt yurtPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yurt"
    ADD CONSTRAINT "yurtPK" PRIMARY KEY ("yurtNo");


--
-- Name: index_kayitNo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_kayitNo" ON public."Kayit" USING btree ("kayitNo");


--
-- Name: Ogrenci kapasiteKontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "kapasiteKontrol" BEFORE INSERT OR UPDATE ON public."Ogrenci" FOR EACH ROW EXECUTE FUNCTION public.kapasite();


--
-- Name: Ogrenci kayit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER kayit AFTER INSERT ON public."Ogrenci" FOR EACH ROW EXECUTE FUNCTION public.kurskayit();


--
-- Name: Kayit kursKapasite; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "kursKapasite" BEFORE INSERT ON public."Kayit" FOR EACH ROW EXECUTE FUNCTION public.kurskapasite();


--
-- Name: Ogrenci yurtKapasite; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "yurtKapasite" BEFORE UPDATE ON public."Ogrenci" FOR EACH ROW EXECUTE FUNCTION public.yurtkapasite();


--
-- Name: Bina binaFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bina"
    ADD CONSTRAINT "binaFK" FOREIGN KEY ("yurtNo") REFERENCES public."Yurt"("yurtNo");


--
-- Name: Dil dil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dil"
    ADD CONSTRAINT dil FOREIGN KEY ("kursNo") REFERENCES public."Kurs"("kursNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Egitmen egitmenFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Egitmen"
    ADD CONSTRAINT "egitmenFK" FOREIGN KEY ("personelNo") REFERENCES public."Personel"("personelNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Egitmen egitmenFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Egitmen"
    ADD CONSTRAINT "egitmenFK2" FOREIGN KEY ("etutNo") REFERENCES public."EtutSalonu"("etutNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: EtutSalonu etutFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EtutSalonu"
    ADD CONSTRAINT "etutFK" FOREIGN KEY ("binaNo") REFERENCES public."Bina"("binaNo");


--
-- Name: Guvenlik guvenlikFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Guvenlik"
    ADD CONSTRAINT "guvenlikFK" FOREIGN KEY ("personelNo") REFERENCES public."Personel"("personelNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Guvenlik guvenlikFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Guvenlik"
    ADD CONSTRAINT "guvenlikFK2" FOREIGN KEY ("binaNo") REFERENCES public."Bina"("binaNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Hademe hademeFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hademe"
    ADD CONSTRAINT "hademeFK" FOREIGN KEY ("personelNo") REFERENCES public."Personel"("personelNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Hademe hademeFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hademe"
    ADD CONSTRAINT "hademeFK2" FOREIGN KEY ("binaNo") REFERENCES public."Bina"("binaNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kayit kayitFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kayit"
    ADD CONSTRAINT "kayitFK" FOREIGN KEY ("ogrenciNo") REFERENCES public."Ogrenci"("ogrenciNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kayit kayitFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kayit"
    ADD CONSTRAINT "kayitFK2" FOREIGN KEY ("kursNo") REFERENCES public."Kurs"("kursNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kurs kursFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kurs"
    ADD CONSTRAINT "kursFK" FOREIGN KEY ("yurtNo") REFERENCES public."Yurt"("yurtNo");


--
-- Name: Kurs kursFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kurs"
    ADD CONSTRAINT "kursFK2" FOREIGN KEY ("etutNo") REFERENCES public."EtutSalonu"("etutNo");


--
-- Name: Muzik muzik; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Muzik"
    ADD CONSTRAINT muzik FOREIGN KEY ("kursNo") REFERENCES public."Kurs"("kursNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Oda odaFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Oda"
    ADD CONSTRAINT "odaFK" FOREIGN KEY ("binaNo") REFERENCES public."Bina"("binaNo");


--
-- Name: Ogrenci ogrenciFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "ogrenciFK" FOREIGN KEY ("odaNo") REFERENCES public."Oda"("odaNo");


--
-- Name: Ogrenci ogrenciFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "ogrenciFK2" FOREIGN KEY ("kursNo") REFERENCES public."Kurs"("kursNo");


--
-- Name: Personel personelFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "personelFK" FOREIGN KEY ("yurtNo") REFERENCES public."Yurt"("yurtNo");


--
-- Name: Yazilim yazilim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazilim"
    ADD CONSTRAINT yazilim FOREIGN KEY ("kursNo") REFERENCES public."Kurs"("kursNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Yonetici yoneticiFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetici"
    ADD CONSTRAINT "yoneticiFK" FOREIGN KEY ("personelNo") REFERENCES public."Personel"("personelNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Yonetici yoneticiFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetici"
    ADD CONSTRAINT "yoneticiFK2" FOREIGN KEY ("binaNo") REFERENCES public."Bina"("binaNo") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

