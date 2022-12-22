![image](https://user-images.githubusercontent.com/26124396/209186386-8bf63b5e-27df-4fd0-8808-2e5aafd40183.png)

![image](https://user-images.githubusercontent.com/26124396/209182419-c62070bb-eab6-43e0-90c4-dacd9ceff3c1.png)

![image](https://user-images.githubusercontent.com/26124396/209182738-021a136e-6e7c-4298-bafd-7b437d756e7e.png)

![image](https://user-images.githubusercontent.com/26124396/209186553-ef561dbd-66e2-4c74-abc2-8d0e4a4a181a.png)

![image](https://user-images.githubusercontent.com/26124396/209183084-87b0c219-7532-4c55-9c83-7f11ea1e5e55.png)

![image](https://user-images.githubusercontent.com/26124396/209186981-fae9b233-8eaa-4bd4-ad57-57831d819be7.png)

_Змінити дані з обраним ім'ям неможливо через обмеження накладені у функції. Ім'я test не було замінено на test0._

<hr>

```sql
select *
from change_data('test'' or spot_conf>0 --', 'test0');
```  
_Через особливість запиту на кількість знайдених записів результат функції залишися рівним нулеві:_  
![image](https://user-images.githubusercontent.com/26124396/209188785-acef2b9a-6992-4c40-b6a9-2cf709c60c40.png)  
_Проте, порушення цілісності даних відбулося:_  
![image](https://user-images.githubusercontent.com/26124396/209189293-f5cb0901-6ede-45f6-aee1-1001749bd014.png)  
_Усі записи таблиці отримали назву задану зловмисником._


