<%!
import sys
sys.path.append('../')
from field import Struct, EnumField, Union, DataType, Multiplicity, Field, PreDeclared
%>
/*****
*
* Copyright (C) 2001-2016 CS-SI. All Rights Reserved.
* Author: Yoann Vandoorselaere <yoann.v@prelude-ids.com>
* Author: Nicolas Delon <nicolas.delon@prelude-ids.com>
*
* This file is part of the LibIodef library.
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2, or (at your option)
* any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
*****/

/*
 * This file was automatically generated by our generator, version ${generator_version}
 *
 * Do not make changes to this file unless you know what you are doing.
 * modify the template interface file instead.
 * ${name_lib.upper()} version : ${lib_version}
 * Template file: generate-tree-data.h.mako
 *
 */

<% bool_prefix = "libidmefv2" if name_lib == "idmefv2" else ("lib" + name_lib) %>
typedef struct {
        const char *name;
        ${bool_prefix}_bool_t list;
        ${bool_prefix}_bool_t keyed_list;
        ${name_lib}_value_type_id_t type;
        ${name_lib}_class_id_t class;
        int union_id;
} children_list_t;
% for obj in lib_classes.obj_list :
% if isinstance(obj, Struct):
<% union_id = 0 %>
const children_list_t ${name_lib}_${obj.short_type_name}_children_list[] = {
% for field in obj.fields_list:
% if  field.data_type == DataType.UNION:
<% union_id += 1 %>
% for member in field.list_member:
<% maj = member.short_type_name.upper() %>        { "${member.name}", 0, 0, ${name_lib.upper()}_VALUE_TYPE_CLASS, ${name_lib.upper()}_CLASS_ID_${maj}, /* union ID */ ${union_id} },
% endfor
% else:
<% list = 0; keyed_list = 0; name = field.name %>
%if field.listed:
<%
    list  = 1; name = field.short_name
    if field.key_listed:
        keyed_list = 1
    if field.data_type == DataType.PRIMITIVE or field.data_type == DataType.PRIMITIVE_STRUCT:
        object  = name_lib.upper() + "_VALUE_TYPE_"+field.value_type.upper(); object_type = 0
    else:
        object = name_lib.upper() + "_VALUE_TYPE_CLASS"
        object_type = name_lib.upper() + "_CLASS_ID_" + (field.short_type_name).upper()
%>
%else:
%if field.data_type == DataType.PRIMITIVE or field.data_type == DataType.PRIMITIVE_STRUCT:
<% object  = name_lib.upper() + "_VALUE_TYPE_"+field.value_type.upper(); object_type = 0 %>
%elif field.data_type == DataType.STRUCT:
<%
    object = name_lib.upper() + "_VALUE_TYPE_CLASS"
    object_type = name_lib.upper() + "_CLASS_ID_" + (field.short_type_name).upper()
%>
%elif  field.data_type == DataType.ENUM:
<%
    object = name_lib.upper() + "_VALUE_TYPE_ENUM"
    object_type = name_lib.upper() + "_CLASS_ID_" + (field.short_type_name).upper()
%>
% endif ##endnormal
% endif #end_else_normal
        { "${name}", ${list}, ${keyed_list}, ${object}, ${object_type}, 0 },
% endif ## end_else_union
% endfor ## end_for_list_field

};

% endif ## end_if_is_struct
% endfor ## end_for_list_obj
<% last_id = -1 ;%>
typedef struct {
        const char *name;
        size_t children_list_elem;
        const children_list_t *children_list;
        int (*get_child)(void *ptr, ${name_lib}_class_child_id_t child, void **ret);
        int (*new_child)(void *ptr, ${name_lib}_class_child_id_t child, int n, void **ret);
        int (*destroy_child)(void *ptr, ${name_lib}_class_child_id_t child, int n);
        int (*to_numeric)(const char *name);
        const char *(*to_string)(int val);
        int (*copy)(const void *src, void *dst);
        int (*clone)(const void *src, void **dst);
        int (*compare)(const void *obj1, const void *obj2);
        int (*print)(const void *obj, ${prefix}_io_t *fd);
        int (*print_json)(const void *obj, ${prefix}_io_t *fd);
        int (*print_binary)(const void *obj, ${prefix}_io_t *fd);
        void *(*ref)(void *src);
        void (*destroy)(void *obj);
        ${bool_prefix}_bool_t is_listed;
} object_data_t;

const object_data_t object_data[] =  {
% for obj in sorted(lib_classes.obj_list, key=lambda obj: obj.ident):
% if  isinstance(obj, Struct) or isinstance(obj, EnumField) :
% for i in xrange(last_id + 1, obj.ident) :
        { "(unassigned)", 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL }, /* ID: ${i} */
% endfor
% if isinstance(obj, Struct):
<% last_id = obj.ident %>        { "${obj.short_type_name}", sizeof(${name_lib}_${obj.short_type_name}_children_list) / sizeof(*${name_lib}_${obj.short_type_name}_children_list), ${name_lib}_${obj.short_type_name}_children_list, _${name_lib}_${obj.short_type_name}_get_child, _${name_lib}_${obj.short_type_name}_new_child, _${name_lib}_${obj.short_type_name}_destroy_child, NULL, NULL, (void *) ${name_lib}_${obj.short_type_name}_copy, (void *) ${name_lib}_${obj.short_type_name}_clone, (void *) ${name_lib}_${obj.short_type_name}_compare, (void *) ${name_lib}_${obj.short_type_name}_print, (void *) ${name_lib}_${obj.short_type_name}_print_json, (void *) ${name_lib}_${obj.short_type_name}_write, (void *) ${name_lib}_${obj.short_type_name}_ref, (void *) ${name_lib}_${obj.short_type_name}_destroy, ${obj.struct_listed} }, /* ID: ${obj.ident} */
% endif
% if isinstance(obj, EnumField):
<% last_id = obj.ident %>        { "${obj.short_type_name}", 0, NULL, NULL, NULL, NULL, (void *) ${name_lib}_${obj.short_type_name}_to_numeric, (void *) ${name_lib}_${obj.short_type_name}_to_string, NULL, NULL, NULL, NULL, NULL, 0 },/* ID: ${obj.ident}  */
% endif
% endif
% endfor
        { NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL }
};
