PGDMP     4                    z           mtaa    14.2    14.2 7    .           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            /           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            0           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            1           1262    16394    mtaa    DATABASE     b   CREATE DATABASE mtaa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Slovak_Slovakia.1250';
    DROP DATABASE mtaa;
                postgres    false            2           0    0    mtaa    DATABASE PROPERTIES     *   ALTER DATABASE mtaa CONNECTION LIMIT = 3;
                     postgres    false            ?            1259    16395    category    TABLE     O   CREATE TABLE public.category (
    categ_id integer NOT NULL,
    name text
);
    DROP TABLE public.category;
       public         heap    postgres    false            ?            1259    16514    chat    TABLE     ?   CREATE TABLE public.chat (
    id integer NOT NULL,
    user_id integer,
    event_id integer,
    message character varying NOT NULL
);
    DROP TABLE public.chat;
       public         heap    postgres    false            ?            1259    16513    chat_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.chat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.chat_id_seq;
       public          postgres    false    218            3           0    0    chat_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.chat_id_seq OWNED BY public.chat.id;
          public          postgres    false    217            ?            1259    16400    cities    TABLE     L   CREATE TABLE public.cities (
    city_id integer NOT NULL,
    name text
);
    DROP TABLE public.cities;
       public         heap    postgres    false            ?            1259    16405    events    TABLE     5  CREATE TABLE public.events (
    id integer NOT NULL,
    name text,
    image text,
    category integer,
    created_on timestamp without time zone,
    date timestamp without time zone,
    capacity integer,
    city integer,
    additional_info text,
    owner integer,
    status boolean DEFAULT true
);
    DROP TABLE public.events;
       public         heap    postgres    false            ?            1259    16484    event_id_seq    SEQUENCE     t   CREATE SEQUENCE public.event_id_seq
    START WITH 3
    INCREMENT BY 1
    MINVALUE 3
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.event_id_seq;
       public          postgres    false    211            4           0    0    event_id_seq    SEQUENCE OWNED BY     >   ALTER SEQUENCE public.event_id_seq OWNED BY public.events.id;
          public          postgres    false    216            ?            1259    16411 	   interests    TABLE     ?   CREATE TABLE public.interests (
    id_user integer,
    skola boolean,
    praca boolean,
    sport boolean,
    verejne_podujatie boolean,
    party boolean,
    umenie boolean,
    cestovanie boolean,
    posedenie boolean,
    ine boolean
);
    DROP TABLE public.interests;
       public         heap    postgres    false            ?            1259    16414    users    TABLE     ?   CREATE TABLE public.users (
    id integer NOT NULL,
    nick_name text NOT NULL,
    password text NOT NULL,
    name text NOT NULL,
    gender boolean NOT NULL,
    age integer NOT NULL,
    city integer NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            ?            1259    16482    test_id_seq    SEQUENCE     s   CREATE SEQUENCE public.test_id_seq
    START WITH 6
    INCREMENT BY 1
    MINVALUE 6
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.test_id_seq;
       public          postgres    false    213            5           0    0    test_id_seq    SEQUENCE OWNED BY     <   ALTER SEQUENCE public.test_id_seq OWNED BY public.users.id;
          public          postgres    false    215            ?            1259    16463    users_events    TABLE     b   CREATE TABLE public.users_events (
    user_id integer NOT NULL,
    event_id integer NOT NULL
);
     DROP TABLE public.users_events;
       public         heap    postgres    false            }           2604    16517    chat id    DEFAULT     b   ALTER TABLE ONLY public.chat ALTER COLUMN id SET DEFAULT nextval('public.chat_id_seq'::regclass);
 6   ALTER TABLE public.chat ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            y           2604    16485 	   events id    DEFAULT     e   ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.event_id_seq'::regclass);
 8   ALTER TABLE public.events ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    211            |           2604    16483    users id    DEFAULT     c   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    213            "          0    16395    category 
   TABLE DATA           2   COPY public.category (categ_id, name) FROM stdin;
    public          postgres    false    209   ?:       +          0    16514    chat 
   TABLE DATA           >   COPY public.chat (id, user_id, event_id, message) FROM stdin;
    public          postgres    false    218   %;       #          0    16400    cities 
   TABLE DATA           /   COPY public.cities (city_id, name) FROM stdin;
    public          postgres    false    210   ?;       $          0    16405    events 
   TABLE DATA           }   COPY public.events (id, name, image, category, created_on, date, capacity, city, additional_info, owner, status) FROM stdin;
    public          postgres    false    211   ?;       %          0    16411 	   interests 
   TABLE DATA              COPY public.interests (id_user, skola, praca, sport, verejne_podujatie, party, umenie, cestovanie, posedenie, ine) FROM stdin;
    public          postgres    false    212   ?<       &          0    16414    users 
   TABLE DATA           Q   COPY public.users (id, nick_name, password, name, gender, age, city) FROM stdin;
    public          postgres    false    213   ?<       '          0    16463    users_events 
   TABLE DATA           9   COPY public.users_events (user_id, event_id) FROM stdin;
    public          postgres    false    214   ?=       6           0    0    chat_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.chat_id_seq', 1, false);
          public          postgres    false    217            7           0    0    event_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.event_id_seq', 5, true);
          public          postgres    false    216            8           0    0    test_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.test_id_seq', 19, true);
          public          postgres    false    215            v           2606    16419    category categ_id    CHECK CONSTRAINT     Z   ALTER TABLE public.category
    ADD CONSTRAINT categ_id CHECK ((categ_id > 0)) NOT VALID;
 6   ALTER TABLE public.category DROP CONSTRAINT categ_id;
       public          postgres    false    209    209                       2606    16421    category category_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (categ_id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    209            ?           2606    16521    chat chat_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.chat DROP CONSTRAINT chat_pkey;
       public            postgres    false    218            ?           2606    16423    cities cities_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_pkey;
       public            postgres    false    210            w           2606    16424    cities city_id    CHECK CONSTRAINT     V   ALTER TABLE public.cities
    ADD CONSTRAINT city_id CHECK ((city_id > 0)) NOT VALID;
 3   ALTER TABLE public.cities DROP CONSTRAINT city_id;
       public          postgres    false    210    210            ?           2606    16426    events events_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
       public            postgres    false    211            z           2606    16429    interests id pouz    CHECK CONSTRAINT     [   ALTER TABLE public.interests
    ADD CONSTRAINT "id pouz" CHECK ((id_user > 0)) NOT VALID;
 8   ALTER TABLE public.interests DROP CONSTRAINT "id pouz";
       public          postgres    false    212    212            {           2606    16430    interests id usera    CHECK CONSTRAINT     \   ALTER TABLE public.interests
    ADD CONSTRAINT "id usera" CHECK ((id_user > 0)) NOT VALID;
 9   ALTER TABLE public.interests DROP CONSTRAINT "id usera";
       public          postgres    false    212    212            ?           2606    16432    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    213            ?           1259    16479    fki_c    INDEX     A   CREATE INDEX fki_c ON public.users_events USING btree (user_id);
    DROP INDEX public.fki_c;
       public            postgres    false    214            ?           1259    16473 	   fki_event    INDEX     F   CREATE INDEX fki_event ON public.users_events USING btree (event_id);
    DROP INDEX public.fki_event;
       public            postgres    false    214            ?           1259    16433    fki_k    INDEX     9   CREATE INDEX fki_k ON public.events USING btree (owner);
    DROP INDEX public.fki_k;
       public            postgres    false    211            ?           1259    16434    fki_kategoria    INDEX     D   CREATE INDEX fki_kategoria ON public.events USING btree (category);
 !   DROP INDEX public.fki_kategoria;
       public            postgres    false    211            ?           1259    16435 	   fki_mesto    INDEX     <   CREATE INDEX fki_mesto ON public.events USING btree (city);
    DROP INDEX public.fki_mesto;
       public            postgres    false    211            ?           1259    16436 
   fki_zaujmy    INDEX     C   CREATE INDEX fki_zaujmy ON public.interests USING btree (id_user);
    DROP INDEX public.fki_zaujmy;
       public            postgres    false    212            ?           2606    16527    chat chat_event_id_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id);
 A   ALTER TABLE ONLY public.chat DROP CONSTRAINT chat_event_id_fkey;
       public          postgres    false    211    3203    218            ?           2606    16522    chat chat_user_id_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 @   ALTER TABLE ONLY public.chat DROP CONSTRAINT chat_user_id_fkey;
       public          postgres    false    3209    213    218            ?           2606    16437 
   users city    FK CONSTRAINT     v   ALTER TABLE ONLY public.users
    ADD CONSTRAINT city FOREIGN KEY (city) REFERENCES public.cities(city_id) NOT VALID;
 4   ALTER TABLE ONLY public.users DROP CONSTRAINT city;
       public          postgres    false    210    3201    213            ?           2606    16468    users_events event    FK CONSTRAINT     }   ALTER TABLE ONLY public.users_events
    ADD CONSTRAINT event FOREIGN KEY (event_id) REFERENCES public.events(id) NOT VALID;
 <   ALTER TABLE ONLY public.users_events DROP CONSTRAINT event;
       public          postgres    false    211    3203    214            ?           2606    16442    events kategoria    FK CONSTRAINT     ?   ALTER TABLE ONLY public.events
    ADD CONSTRAINT kategoria FOREIGN KEY (category) REFERENCES public.category(categ_id) NOT VALID;
 :   ALTER TABLE ONLY public.events DROP CONSTRAINT kategoria;
       public          postgres    false    211    3199    209            ?           2606    16447    events mesto    FK CONSTRAINT     x   ALTER TABLE ONLY public.events
    ADD CONSTRAINT mesto FOREIGN KEY (city) REFERENCES public.cities(city_id) NOT VALID;
 6   ALTER TABLE ONLY public.events DROP CONSTRAINT mesto;
       public          postgres    false    210    211    3201            ?           2606    16474    users_events pouzivatel    FK CONSTRAINT     ?   ALTER TABLE ONLY public.users_events
    ADD CONSTRAINT pouzivatel FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;
 A   ALTER TABLE ONLY public.users_events DROP CONSTRAINT pouzivatel;
       public          postgres    false    214    213    3209            ?           2606    16452    events zakladtel    FK CONSTRAINT     w   ALTER TABLE ONLY public.events
    ADD CONSTRAINT zakladtel FOREIGN KEY (owner) REFERENCES public.users(id) NOT VALID;
 :   ALTER TABLE ONLY public.events DROP CONSTRAINT zakladtel;
       public          postgres    false    211    3209    213            ?           2606    16457    interests zaujmy    FK CONSTRAINT     y   ALTER TABLE ONLY public.interests
    ADD CONSTRAINT zaujmy FOREIGN KEY (id_user) REFERENCES public.users(id) NOT VALID;
 :   ALTER TABLE ONLY public.interests DROP CONSTRAINT zaujmy;
       public          postgres    false    212    213    3209            "   )   x?3?H,*??2?.)M???K?2?.?/*)?????? ?N	j      +   ^   x?3?4B??ҒT???Ԓ?L+M.#N#?p^bUJb??Bi?Bq?BIjqf?"?1?1P?1K!+.?`墐??????PP????Z\b?????? 2?      #   (   x?3?t*J,?,?I,K?2?)?1?9?2K??b???? ??	?      $     x???Ok?0?????u?ıӮ40Fv(??C??P??$??G??>??-??:==??$N?????~$?0f??+?????Ү?"?e/?<???u?L?V?N??=???.?+ٓ?.????ɷt^ND"D???XO?d?E[E||???E??z??*?C?V?; ? dY)??0??_C㛟???G<h?EKg?E???u?????ˇ????#Ҕ?<*???!_??/I?Y??+'?!?#?6?7?*?G??9??~ i?1      %      x?????? ? ?      &   ?   x??;?0D??)|??CA??(,? ?I$????§g?)?y?q??$hT????8????G-??5?g???=?G??H-f?e? ? pf{?????f?r?E????K??;?^g?N????n7???~??1%?*?      '   !   x?3?4?2bc 6?4?2bC0ې+F??? B??     