PGDMP         .                z           mtaa    14.2    14.2 )                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            !           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            "           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            #           1262    16394    mtaa    DATABASE     b   CREATE DATABASE mtaa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Slovak_Slovakia.1250';
    DROP DATABASE mtaa;
                postgres    false            $           0    0    mtaa    DATABASE PROPERTIES     *   ALTER DATABASE mtaa CONNECTION LIMIT = 3;
                     postgres    false            �            1259    16395    category    TABLE     O   CREATE TABLE public.category (
    categ_id integer NOT NULL,
    name text
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    16400    cities    TABLE     L   CREATE TABLE public.cities (
    city_id integer NOT NULL,
    name text
);
    DROP TABLE public.cities;
       public         heap    postgres    false            �            1259    16405    events    TABLE     0  CREATE TABLE public.events (
    id integer NOT NULL,
    name text,
    image bytea,
    category integer,
    created_on timestamp with time zone,
    date timestamp with time zone,
    capacity integer,
    city integer,
    additional_info text,
    owner integer,
    status boolean DEFAULT true
);
    DROP TABLE public.events;
       public         heap    postgres    false            �            1259    16411 	   interests    TABLE     �   CREATE TABLE public.interests (
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
       public         heap    postgres    false            �            1259    16414    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    nick_name text NOT NULL,
    password text NOT NULL,
    name text NOT NULL,
    gender boolean NOT NULL,
    age integer NOT NULL,
    city integer NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16463    users_events    TABLE     ~   CREATE TABLE public.users_events (
    "id " integer NOT NULL,
    user_id integer NOT NULL,
    event_id integer NOT NULL
);
     DROP TABLE public.users_events;
       public         heap    postgres    false                      0    16395    category 
   TABLE DATA           2   COPY public.category (categ_id, name) FROM stdin;
    public          postgres    false    209   �,                 0    16400    cities 
   TABLE DATA           /   COPY public.cities (city_id, name) FROM stdin;
    public          postgres    false    210   -                 0    16405    events 
   TABLE DATA           }   COPY public.events (id, name, image, category, created_on, date, capacity, city, additional_info, owner, status) FROM stdin;
    public          postgres    false    211   ?-                 0    16411 	   interests 
   TABLE DATA              COPY public.interests (id_user, skola, praca, sport, verejne_podujatie, party, umenie, cestovanie, posedenie, ine) FROM stdin;
    public          postgres    false    212   �-                 0    16414    users 
   TABLE DATA           Q   COPY public.users (id, nick_name, password, name, gender, age, city) FROM stdin;
    public          postgres    false    213   .                 0    16463    users_events 
   TABLE DATA           @   COPY public.users_events ("id ", user_id, event_id) FROM stdin;
    public          postgres    false    214   �.       o           2606    16419    category categ_id    CHECK CONSTRAINT     Z   ALTER TABLE public.category
    ADD CONSTRAINT categ_id CHECK ((categ_id > 0)) NOT VALID;
 6   ALTER TABLE public.category DROP CONSTRAINT categ_id;
       public          postgres    false    209    209            w           2606    16421    category category_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (categ_id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    209            y           2606    16423    cities cities_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_pkey;
       public            postgres    false    210            p           2606    16424    cities city_id    CHECK CONSTRAINT     V   ALTER TABLE public.cities
    ADD CONSTRAINT city_id CHECK ((city_id > 0)) NOT VALID;
 3   ALTER TABLE public.cities DROP CONSTRAINT city_id;
       public          postgres    false    210    210            {           2606    16426    events events_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
       public            postgres    false    211            u           2606    16427    users id    CHECK CONSTRAINT     K   ALTER TABLE public.users
    ADD CONSTRAINT id CHECK ((id > 0)) NOT VALID;
 -   ALTER TABLE public.users DROP CONSTRAINT id;
       public          postgres    false    213    213            r           2606    16428 	   events id    CHECK CONSTRAINT     L   ALTER TABLE public.events
    ADD CONSTRAINT id CHECK ((id > 0)) NOT VALID;
 .   ALTER TABLE public.events DROP CONSTRAINT id;
       public          postgres    false    211    211            s           2606    16429    interests id pouz    CHECK CONSTRAINT     [   ALTER TABLE public.interests
    ADD CONSTRAINT "id pouz" CHECK ((id_user > 0)) NOT VALID;
 8   ALTER TABLE public.interests DROP CONSTRAINT "id pouz";
       public          postgres    false    212    212            t           2606    16430    interests id usera    CHECK CONSTRAINT     \   ALTER TABLE public.interests
    ADD CONSTRAINT "id usera" CHECK ((id_user > 0)) NOT VALID;
 9   ALTER TABLE public.interests DROP CONSTRAINT "id usera";
       public          postgres    false    212    212            �           2606    16467    users_events users_events_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.users_events
    ADD CONSTRAINT users_events_pkey PRIMARY KEY ("id ");
 H   ALTER TABLE ONLY public.users_events DROP CONSTRAINT users_events_pkey;
       public            postgres    false    214            �           2606    16432    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    213            �           1259    16479    fki_c    INDEX     A   CREATE INDEX fki_c ON public.users_events USING btree (user_id);
    DROP INDEX public.fki_c;
       public            postgres    false    214            �           1259    16473 	   fki_event    INDEX     F   CREATE INDEX fki_event ON public.users_events USING btree (event_id);
    DROP INDEX public.fki_event;
       public            postgres    false    214            |           1259    16433    fki_k    INDEX     9   CREATE INDEX fki_k ON public.events USING btree (owner);
    DROP INDEX public.fki_k;
       public            postgres    false    211            }           1259    16434    fki_kategoria    INDEX     D   CREATE INDEX fki_kategoria ON public.events USING btree (category);
 !   DROP INDEX public.fki_kategoria;
       public            postgres    false    211            ~           1259    16435 	   fki_mesto    INDEX     <   CREATE INDEX fki_mesto ON public.events USING btree (city);
    DROP INDEX public.fki_mesto;
       public            postgres    false    211                       1259    16436 
   fki_zaujmy    INDEX     C   CREATE INDEX fki_zaujmy ON public.interests USING btree (id_user);
    DROP INDEX public.fki_zaujmy;
       public            postgres    false    212            �           2606    16437 
   users city    FK CONSTRAINT     v   ALTER TABLE ONLY public.users
    ADD CONSTRAINT city FOREIGN KEY (city) REFERENCES public.cities(city_id) NOT VALID;
 4   ALTER TABLE ONLY public.users DROP CONSTRAINT city;
       public          postgres    false    213    3193    210            �           2606    16468    users_events event    FK CONSTRAINT     }   ALTER TABLE ONLY public.users_events
    ADD CONSTRAINT event FOREIGN KEY (event_id) REFERENCES public.events(id) NOT VALID;
 <   ALTER TABLE ONLY public.users_events DROP CONSTRAINT event;
       public          postgres    false    211    3195    214            �           2606    16442    events kategoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.events
    ADD CONSTRAINT kategoria FOREIGN KEY (category) REFERENCES public.category(categ_id) NOT VALID;
 :   ALTER TABLE ONLY public.events DROP CONSTRAINT kategoria;
       public          postgres    false    3191    209    211            �           2606    16447    events mesto    FK CONSTRAINT     x   ALTER TABLE ONLY public.events
    ADD CONSTRAINT mesto FOREIGN KEY (city) REFERENCES public.cities(city_id) NOT VALID;
 6   ALTER TABLE ONLY public.events DROP CONSTRAINT mesto;
       public          postgres    false    3193    210    211            �           2606    16474    users_events pouzivatel    FK CONSTRAINT     �   ALTER TABLE ONLY public.users_events
    ADD CONSTRAINT pouzivatel FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;
 A   ALTER TABLE ONLY public.users_events DROP CONSTRAINT pouzivatel;
       public          postgres    false    214    3201    213            �           2606    16452    events zakladtel    FK CONSTRAINT     w   ALTER TABLE ONLY public.events
    ADD CONSTRAINT zakladtel FOREIGN KEY (owner) REFERENCES public.users(id) NOT VALID;
 :   ALTER TABLE ONLY public.events DROP CONSTRAINT zakladtel;
       public          postgres    false    3201    213    211            �           2606    16457    interests zaujmy    FK CONSTRAINT     y   ALTER TABLE ONLY public.interests
    ADD CONSTRAINT zaujmy FOREIGN KEY (id_user) REFERENCES public.users(id) NOT VALID;
 :   ALTER TABLE ONLY public.interests DROP CONSTRAINT zaujmy;
       public          postgres    false    3201    212    213                  x�3�H,*��2�MN��L����� F��         (   x�3�t*J,�,�I,K�2�)�1�9�2K��b���� ��	�         �   x�m�=�0��˯�U��\,b�.B� ���4C?#i"�7A��p�s��	���O\4^���'ʸ�(G�O��>f���O*�/f�ζ.ĲIw���3�[;�ѣ�)t�N�Y�K���	d�X�L3#�g��G����a]�Ez�co�>5�            x������ � �         �   x�%��
�0���ק�ȺMУ<���`W���v�>�����O�"� htp�ڛ������L��K��8�sa��H/-�:z,��7�x�H�!�i�ީ�Rb���1Q��?�N����(��N���dҢ^x�1_޴,�            x������ � �     