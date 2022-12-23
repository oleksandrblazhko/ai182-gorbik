create or replace function get_data(university_name varchar)
    returns table (u_id integer, name varchar, year integer) as $$
declare
    query_str varchar;
begin
    query_str := 'select u_id, name, year from university where name = ''' || university_name || '''';
    raise notice 'Query=%', query_str;
    return query execute query_str;
end;
$$ language plpgsql;
