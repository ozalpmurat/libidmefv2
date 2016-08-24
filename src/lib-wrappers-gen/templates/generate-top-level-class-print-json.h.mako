<%!
import sys
sys.path.append('../')
from field import Struct
%>
/*****
*
* Copyright (C) 2003-2016 CS-SI. All Rights Reserved.
* Author: Yoann Vandoorselaere <yoann.v@prelude-ids.com>
*
* This file is part of the ${prefix.capitalize()} library.
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
 * Template file: generate-additional-data.c.mako
 *
 */

#ifndef _${prefix.upper()}_${name_lib.upper()}_${top_class.upper()}_PRINT_JSON_H
#define _${prefix.upper()}_${name_lib.upper()}_${top_class.upper()}_PRINT_JSON_H

#ifdef __cplusplus
 extern "C" {
#endif
% for obj in lib_classes.obj_list :
% if isinstance(obj, Struct):
int ${name_lib}_${obj.short_type_name}_print_json(${obj.type_name} *ptr, ${prefix}_io_t *fd);
% endif ## is_struct
% endfor ##obj_list

int ${name_lib}_${top_class}_print_json(${name_lib}_${top_class}_t *ptr, ${prefix}_io_t *fd);

#ifdef __cplusplus
 }
#endif

#endif /* _${prefix.upper()}_${name_lib.upper()}_${top_class.upper()}_JSON_H */
