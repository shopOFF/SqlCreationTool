declare
    v_attribute_id     number;
begin
    delete validation_attributes where obj_attrs like '%df_qbe_homebusiness%'

    -- ***************************************************
    -- unabletocompletereason
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'unabletocompletereason';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'YES', 'Is required when Unable to Complete is Yes.');

    -- ***************************************************
    -- businesslocation
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'businesslocation';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- businesshours
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'businesshours';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- customersonsite
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'customersonsite';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- merchandiseforsale
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'merchandiseforsale';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- insureditemssolddesc
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'insureditemssolddesc';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.insureditemssold', 'YES', 'Is required when Does insured make items sold is Yes.');

    -- ***************************************************
    -- chemicalsonsite
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'chemicalsonsite';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- chemicalsonsitedesc
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'chemicalsonsitedesc';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.', 'YES', 'Is required when Any flammable or hazardous chemicals kept on site is Yes.');

    -- ***************************************************
    -- itemsplace
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'itemsplace';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.', 'YES', 'Is required when Any flammable or hazardous chemicals kept on site is Yes.');

    -- ***************************************************
    -- specialequipment
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'specialequipment';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- specialequipmentdesc
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'specialequipmentdesc';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.specialequipment', 'YES', 'Is required when Any special equipment in the business is Yes.');

    -- ***************************************************
    -- housekeepingissues
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'housekeepingissues';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- deckporchcondition
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'deckporchcondition';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- animals
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'animals';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- employees
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'employees';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- employeesfulltime
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'employeesfulltime';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.employees', 'YES', 'Is required when Are there any full or part-time employees connected to the business is Yes.');

    -- ***************************************************
    -- employeesparttime
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'employeesparttime';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.employees', 'YES', 'Is required when Are there any full or part-time employees connected to the business is Yes.');

    -- ***************************************************
    -- businessfood
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'businessfood';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.unabletocomplete', 'NO', 'Is required when Unable to Complete is No.');

    -- ***************************************************
    -- commercialappliances
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'commercialappliances';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.businessfood', 'YES', 'Is required when Does the business involve food services? is Yes.');

    -- ***************************************************
    -- commercialappliancesdesc
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'commercialappliancesdesc';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.', 'YES', 'Is required when Any commerical appliances is Yes.');

    -- ***************************************************
    -- sprinklersystem
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'sprinklersystem';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.businessfood', 'YES', 'Is required when Does the business involve food services? is Yes.');

    -- ***************************************************
    -- sprinklersystemdesc
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'sprinklersystemdesc';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.sprinklersystem', 'YES', 'Is required when Any sprinkler or Ansul system is Yes.');

    -- ***************************************************
    -- ingredientslabeled
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'ingredientslabeled';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.businessfood', 'YES', 'Is required when Does the business involve food services? is Yes.');

    -- ***************************************************
    -- foodareanotclean
    select attribute_id into v_attribute_id from acs_attributes where object_type = 'df_qbe_homebusiness' and attribute_name = 'foodareanotclean';
    insert into validation_attributes (ATTRIBUTE_ID,FORMULA,OBJ_ATTRS,CHECK_VALUE,VALIDATION_DESCRIPTION) values(v_attribute_id, 'standard_validation.requiredpriorexplicit (:1, :2, :3, :4, :5, :6, :7)', 'df_qbe_homebusiness.businessfood', 'YES', 'Is required when Does the business involve food services? is Yes.');

    commit;
end;
/
