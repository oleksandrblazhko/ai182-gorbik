```sql
select *
from university;

select *
from change_data_secure('test'' or spot_conf>0 --', 'test23');

select *
from university;
```  

![image](https://user-images.githubusercontent.com/26124396/209228605-03e27a01-4da3-4d62-98e2-07488e6f4e22.png)

![image](https://user-images.githubusercontent.com/26124396/209228355-06f86c2e-7e05-4e8b-8c97-e9daa9a5efa0.png)

![image](https://user-images.githubusercontent.com/26124396/209228446-2cf283ec-cf94-48bb-9cdc-8b1f26e75afc.png)

![image](https://user-images.githubusercontent.com/26124396/209228691-4ba39437-0532-49f4-b334-62fbe9c26f4e.png)

_Як видно, змінити дані не вдалося._

<hr>

```sql
select *
from get_data_secure('any'' or 1=1 -- ');
```  

![image](https://user-images.githubusercontent.com/26124396/209230014-1c4e044f-4e23-419b-89ff-f808968cf257.png)  
_Видно, що отримати усі записи не вдалося_

_Для порівняння виконаємо ще раз запит без захисту від ін'єкцій:_

```sql
select *
from get_data('any'' or 1=1 -- ');
```  

![image](https://user-images.githubusercontent.com/26124396/209230197-a66eb5b0-578a-47ac-a7f9-3cdfb65b6e8a.png)

_(звернення до функції, що не має захисту)_
