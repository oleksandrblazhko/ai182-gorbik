1. Створіть у БД структури даних, необхідні для роботи повноважного керування доступом.

    ```sql
    drop table if exists access_levels cascade;
    create table access_levels
    (
    access_level_id integer primary key,
    access_level    varchar unique
    );
    insert into access_levels
    values (1, 'public');
    insert into access_levels
    values (2, 'private');
    insert into access_levels
    values (3, 'secret');
    insert into access_levels
    values (4, 'topsecret');
    drop table if exists role_access_level cascade;
    create table role_access_level
    (
    role_name    varchar primary key,
    access_level integer references access_levels (access_level_id)
    );
    revoke all on role_access_level from group gorbik;
    grant select on role_access_level to group gorbik;
    ```  
   ![image](https://user-images.githubusercontent.com/26124396/208315650-6e2636a4-dd06-4e52-9e69-c8a9bd930b39.png)

2. Визначте для кожного рядка таблиці мітки конфіденційності (для кожного рядка свою мітку).
   ```sql
   alter table university
   add column spot_conf integer default 3
   references access_levels (access_level_id);
   
   
   update public.university
   set spot_conf = 2;
   update public.university
   set spot_conf = 3
   where u_id <= 4;
   ```  
   ![image](https://user-images.githubusercontent.com/26124396/208315891-240d7012-9769-4197-86d8-76351e8d6d60.png)  
   ![image](https://user-images.githubusercontent.com/26124396/208315938-9bbacb22-7423-41b6-ba37-b6aa13b769a0.png)
3. Визначте для користувача його рівень доступу
   ```sql
   insert into role_access_level
   values ('gorbik', 2);
   ```
4. Створіть нову схему даних.
   ```sql
   drop schema if exists gorbik cascade;
   create schema gorbik;
   alter schema gorbik owner to gorbik;
   ```  
   ![image](https://user-images.githubusercontent.com/26124396/208317431-e3f4fec8-6e4b-497a-af6b-f714a918efde.png)
5. Створіть віртуальну таблицю, назва якої співпадає з назвою реальної таблиці та яка забезпечує SELECT-правила
   повноважного керування доступом для користувача.  
   ```sql
   drop view if exists gorbik.university;
   create view gorbik.university as
   select u_id, name, year
   from public.university u,
        role_access_level ral
   where ral.role_name in (select * from current_user_roles)
     and ral.access_level >= u.spot_conf;
   
   revoke all on public.university from gorbik;
   
   grant select, insert, update, delete
    on gorbik.university
    to gorbik;
   ```  
   ![image](https://user-images.githubusercontent.com/26124396/208318659-e4076c84-3252-4300-aaeb-9acbba75344b.png)
6. Створіть INSERT/UPDATE/DELETE-правила повноважного керування доступом для користувача.  
   ```sql
   create or replace rule university_insert as
       on insert to gorbik.university
       do instead
       insert into public.university
   select new.u_id, new.name, new.year, ral.access_level
   from role_access_level ral
   where ral.role_name in (select * from current_user_roles);
   
   create or replace rule university_update as
       on update to gorbik.university
                    do instead
   update public.university
   set u_id=new.u_id,
       name=new.name,
       year=new.year,
       spot_conf=ral.access_level
      from role_access_level ral
   where ral.role_name in (select * from current_user_roles) and u_id=old.u_id;
   
   create or replace rule university_delete as
       on delete to gorbik.university
       do instead
   delete
   from public.university
   where u_id = old.u_id;
   ```  
   ![image](https://user-images.githubusercontent.com/26124396/208318355-3fbb233a-2ccb-4d67-bba5-ae810efea688.png)
7. Перевірте роботу механізму повноважного керування, виконавши операції SELECT, INSERT, UPDATE, DELETE  
   ![image](https://user-images.githubusercontent.com/26124396/208319273-34aff4a5-a2df-4a33-925c-81326a0ad7b0.png)  
   ![image](https://user-images.githubusercontent.com/26124396/208319296-735c8cfe-e7fc-4ed4-89bc-a2d5c25fe77f.png)  
   ![image](https://user-images.githubusercontent.com/26124396/208319351-b93b19f7-7dfc-4371-96f8-3351f2f70584.png)  
   ![image](https://user-images.githubusercontent.com/26124396/208319371-f4e2298e-2665-4096-88ae-cb3604366954.png)  
   ![image](https://user-images.githubusercontent.com/26124396/208319538-92cc6675-942a-4c99-85b8-10838d41cd32.png)  
   ![image](https://user-images.githubusercontent.com/26124396/208319556-bb152b99-2029-41f8-b1a4-70aa7e28fe03.png)  
*_Запити `select` виконувалися від користувача postgres_
