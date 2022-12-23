drop function if exists change_data_secure(character varying, character varying);
create function change_data_secure(old_name varchar, new_name varchar) returns integer as
$$
declare
    query_str    varchar;
    count_result integer;
begin
    select count(*) into count_result from university where name = old_name and spot_conf < 3;
    query_str := 'update university set name = $1 where name = $2 and spot_conf<3';
    raise notice 'Query: %', query_str;
    execute query_str using new_name, old_name;
    return count_result;
end ;
$$ language plpgsql;
