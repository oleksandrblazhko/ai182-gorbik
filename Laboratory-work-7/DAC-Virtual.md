1. Заповніть таблицю БД ще трьома рядками.  
   ![image](https://user-images.githubusercontent.com/26124396/208247203-1cacceeb-f623-4cdc-b172-700d9c9d2232.png)  
   ![image](https://user-images.githubusercontent.com/26124396/208247296-592d92b8-fca5-47b5-9dc1-8a9cfe35bca1.png)
2. Створіть схему даних користувача та віртуальну таблицю у цій схемі з правилами вибіркового керування доступом для
   користувача так, щоб він міг побачити тільки один з рядків таблиці з урахуванням одного значення її останньої
   колонки.  
   _Створимо умову, за якою користувач, що має роль `gorbik` зможе переглядати університети, в яких рік заснування не
   менший за 2022_  
   ```sql
   create table role2university
   (
   role_name varchar,
   year      integer
   );
   insert into role2university
   values ('gorbik', 2022);
   grant select on university to gorbik;
   grant select on role2university to gorbik;
   
   create schema gorbik;
   alter schema gorbik owner to gorbik;

   create or replace view current_user_roles as
   with recursive cur_user_id as (select oid
                                  from pg_roles
                                  where rolname = current_user
                                  union all
                                  select m.roleid
                                  from cur_user_id
                                      join pg_auth_members m on m.member = cur_user_id.oid)
   select oid::regrole::text as rolename
   from cur_user_id;
   create or replace view gorbik.university as
   select u.*
   from public.university u,
        role2university ru
   where ru.role_name in (select * from current_user_roles)
     and ru.year <= u.year;
   
   grant select on gorbik.university to gorbik;
   revoke select on public.university from gorbik;
   ```  
   ![image](https://user-images.githubusercontent.com/26124396/208247425-a4bc092d-2a7f-4ca3-8ad9-3f36782a7e65.png)
3. Перевірте роботу механізму вибіркового керування, виконавши операції SELECT, INSERT, UPDATE, DELETE.
   ```sql
   select * from gorbik.university;
   ```  
   ![image](https://user-images.githubusercontent.com/26124396/208247470-e79b4a13-4b9b-46e9-8c68-1fdf57db9104.png)
   ```sql
   insert into gorbik.university
   values (6, 'test6', 2023);
   ```
   ![image](https://user-images.githubusercontent.com/26124396/208247574-c0b62803-1e93-4a3c-b407-f3f388325ff6.png)
   ```sql
   update gorbik.university u set name='test6' where name='test5';
   ```
   ![image](https://user-images.githubusercontent.com/26124396/208247730-533be053-7dee-457d-832b-7d6bc53a5e08.png)
   ```sql
   delete from gorbik.university;
   ```
   ![image](https://user-images.githubusercontent.com/26124396/208247830-f3abc861-68a6-4f35-a358-82c842fa5690.png)
