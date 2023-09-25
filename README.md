# Taller de Flutter

Este proyecto será realizado en el marco del Taller de Flutter, Septiembre de 2023

## Instrucciones

1. [Instalar Flutter](https://docs.flutter.dev/get-started/install)

2. [Crear proyecto de Supabase](https://supabase.com/)

3. [Configurar Editor](https://docs.flutter.dev/get-started/editor)

4. Crear proyecto de Flutter:

    ```bash
    flutter create taller 
    ```

5. Añadir las dependencias especificadas en el [pubspec.yaml](pubspec.yaml)

6. Crear archivo .env para configurar Supabase

    ```bash
    SUPABASE_URL=TU_URL
    SUPABASE_KEY=TU_KEY
    ```

7. Habilitar Auth Email y deshabilitar el confirm email desde la pantalla de providers de Supabase

8. Crear tablas SQL:

```sql
CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "first_name" "text",
    "last_name" "text",
    "url" "text"
);

ALTER TABLE "public"."profiles" OWNER TO "postgres";

ALTER TABLE ONLY "public"."profiles"
ADD CONSTRAINT "profile_pkey" PRIMARY KEY ("id");


ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


CREATE POLICY "Public profiles are viewable by everyone." ON "public"."profiles" FOR SELECT USING (true);

CREATE POLICY "Users can insert their own profile." ON "public"."profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "id"));

CREATE POLICY "Users can update own profile." ON "public"."profiles" FOR UPDATE USING (("auth"."uid"() = "id"));

ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
    INSERT INTO public.profiles (id) VALUES (new.id);
    RETURN new;
END;
$$;

ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";
```

### Demo

![Frame 19](https://github.com/unacorbatanegra/taller_flutter/assets/44511181/07c32075-7913-4558-b392-38693ab5f0ba)

### Tarea de Clase 2

1. En el menu, agregar una entrada que nos lleve a nuestro perfil.

2. Crear una pantalla que nos permita editar el perfil del usuario

![simulator_screenshot_7514328C-AB73-4F59-BCB7-DF8F657C8F22](https://github.com/unacorbatanegra/taller/assets/44511181/b172df8a-db06-48b9-83d5-6346ab95c85a)



