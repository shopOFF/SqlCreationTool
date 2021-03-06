create or replace package body df_hartford_hurricane
is
    function new (
        object_id               in df_hartford_hurricanes.object_id%TYPE default null,
        object_type             in acs_objects.object_type%TYPE default 'df_hartford_hurricane',
        creation_date           in acs_objects.creation_date%TYPE default sysdate,
        creation_user           in acs_objects.creation_user%TYPE default null,
        creation_ip             in acs_objects.creation_ip%TYPE default null,
        context_id              in acs_objects.context_id%TYPE default null
    ) return df_hartford_hurricanes.object_id%TYPE
    is
		v_object_id df_hartford_hurricanes.object_id%TYPE;
    begin
		v_object_id := acs_object.new (
			object_id => object_id,
            object_type => object_type,
            creation_date => creation_date,
            creation_user => creation_user,
            creation_ip => creation_ip,
            context_id => context_id
        );

        insert into df_hartford_hurricanes
			(object_id)
        values
			(v_object_id); 

        return v_object_id;
    end new;

    procedure delete (
        i_object_id in df_hartford_hurricanes.object_id%TYPE
    )
        is
            begin
                delete from df_hartford_hurricanes
                where  object_id = i_object_id;
                acs_object.delete(i_object_id);
    end delete;
end df_hartford_hurricane;
/
show errors;
