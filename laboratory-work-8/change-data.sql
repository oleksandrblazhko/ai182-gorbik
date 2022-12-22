drop function if exists change_data(character varying, character varying)
create function change_data(old_name varchar, new_name varchar) returns integer as
$$
declare
    query_str    varchar;
    count_result integer;
begin
    select count(*) into count_result from university where name = old_name and spot_conf < 3;
    query_str := 'update university set name = ''' || new_name || ''' where name = ''' || old_name ||
                 ''' and spot_conf<3';
    raise notice 'Query: %', query_str;
    execute query_str;
    return count_result;
end ;
$$ language plpgsql;
