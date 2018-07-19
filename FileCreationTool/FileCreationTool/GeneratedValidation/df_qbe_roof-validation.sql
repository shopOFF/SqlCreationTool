declare
    v_attribute_id     number;
begin
    delete validation_attributes where obj_attrs like '%df_qbe_roof%'

    -- ***************************************************
    -- utcreason
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'utcreason';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'YES', 'Is required when Unable to Complete is Yes.');

    -- ***************************************************
    -- roofinspectionconductedfrom
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'roofinspectionconductedfrom';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- estimateroofliferemaining
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'estimateroofliferemaining';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- roofrating
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'roofrating';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- anypriordamagerepairs
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'anypriordamagerepairs';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- roofrepairsmade
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'roofrepairsmade';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.anypriordamagerepairs', 'YES', 'Is required when Any Prior Damage/Repairs is Yes.');

    -- ***************************************************
    -- roofstyle
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'roofstyle';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- roofpitch
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'roofpitch';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- excessivegranularloss
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'excessivegranularloss';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- impactmarks
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'impactmarks';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- missingshingles
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'missingshingles';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- roofpatched
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'roofpatched';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- patchtype
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_roof' and attribute_name = 'patchtype';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.utcroof', 'NO', 'Is required when Unable to Complete is No.');
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_roof.roofpatched', 'YES', 'Is required when Roof Patched is Yes.');

    commit;
end;
/
