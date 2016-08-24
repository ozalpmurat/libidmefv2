<%!
import sys
sys.path.append('../')
from field import Struct, EnumField, Union, DataType, Field, PreDeclared
%>
/*****
*
* Copyright (C) 2004-2016 CS-SI. All Rights Reserved.
* Author: Yoann Vandoorselaere <yoann.v@prelude-ids.com>
* Author: Nicolas Delon <nicolas.delon@prelude-ids.com>
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
 * Template file: generate-top-level-class-print.c.mako
 *
 */

#include "config.h"
#include "libmissing.h"

#include <stdio.h>

#include "${name_lib}.h"
#include "${name_lib}-tree-wrap.h"
#include "${name_lib}-${top_class}-print.h"


static int indent = 0;

static void print_indent(${prefix}_io_t *fd)
{
        int cnt;

        for ( cnt = 0; cnt < indent; cnt++ )
                ${prefix}_io_write(fd, " ", 1);
}



static void print_string(${prefix}_string_t *string, ${prefix}_io_t *fd)
{
        if ( ${prefix}_string_is_empty(string) )
                ${prefix}_io_write(fd, "<empty>", 7);
        else
                ${prefix}_io_write(fd, ${prefix}_string_get_string(string), ${prefix}_string_get_len(string));
}



static void print_uint8(uint8_t i, ${prefix}_io_t *fd)
{
        int len;
        char buf[sizeof("255")];

        /*
         * %hh convertion specifier is not portable.
         */
        len = snprintf(buf, sizeof(buf), "%u", (unsigned int) i);
        ${prefix}_io_write(fd, buf, len);
}


static void print_uint16(uint16_t i, ${prefix}_io_t *fd)
{
        int len;
        char buf[sizeof("65535")];

        len = snprintf(buf, sizeof(buf), "%hu", i);
        ${prefix}_io_write(fd, buf, len);
}


static void print_int32(int32_t i, ${prefix}_io_t *fd)
{
        int len;
        char buf[sizeof("4294967296")];

        len = snprintf(buf, sizeof(buf), "%d", i);
        ${prefix}_io_write(fd, buf, len);
}


static void print_uint32(uint32_t i, ${prefix}_io_t *fd)
{
        int len;
        char buf[sizeof("4294967296")];

        len = snprintf(buf, sizeof(buf), "%u", i);
        ${prefix}_io_write(fd, buf, len);
}



static void print_uint64(uint64_t i, ${prefix}_io_t *fd)
{
        int len;
        char buf[sizeof("18446744073709551616")];

        len = snprintf(buf, sizeof(buf), "%" ${prefix.upper()}_PRIu64, i);
        ${prefix}_io_write(fd, buf, len);
}



static void print_float(float f, ${prefix}_io_t *fd)
{
        int len;
        char buf[32];

        len = snprintf(buf, sizeof(buf), "%f", f);
        ${prefix}_io_write(fd, buf, len);
}




static void print_time(${name_lib}_time_t *t, ${prefix}_io_t *fd)
{
        int len;
        time_t _time;
        struct tm _tm;
        char tmp[32], buf[128];

        _time = ${name_lib}_time_get_sec(t) + ${name_lib}_time_get_gmt_offset(t);

        if ( ! gmtime_r(&_time, &_tm) )
                return;

        len = strftime(tmp, sizeof(tmp), "%d/%m/%Y %H:%M:%S", &_tm);
        if ( len == 0 )
                return;

        len = snprintf(buf, sizeof(buf), "%s.%u %+.2d:%.2d",
                       tmp, ${name_lib}_time_get_usec(t), ${name_lib}_time_get_gmt_offset(t) / 3600,
                       ${name_lib}_time_get_gmt_offset(t) % 3600 / 60);

        ${prefix}_io_write(fd, buf, len);
}



/* print data as a string */

static int print_data(${name_lib}_data_t *data, ${prefix}_io_t *fd)
{
        int ret;
        ${prefix}_string_t *out;

        ret = ${prefix}_string_new(&out);
        if ( ret < 0 )
                return ret;

        ret = ${name_lib}_data_to_string(data, out);
        if ( ret < 0 ) {
                ${prefix}_string_destroy(out);
                return ret;
        }

        ${prefix}_io_write(fd, ${prefix}_string_get_string(out), ${prefix}_string_get_len(out));
        ${prefix}_string_destroy(out);

        return 0;
}



static void print_enum(const char *s, int i, ${prefix}_io_t *fd)
{
        int len;
        char buf[512];

        if ( ! s )
                s = "<invalid enum value>";

        len = snprintf(buf, sizeof(buf), "%s (%d)", s, i);
        ${prefix}_io_write(fd, buf, len);
}
% for obj in lib_classes.obj_list :
% if isinstance(obj, Struct) :
/**
 * ${name_lib}_${obj.short_type_name}_print:
 * @ptr: Pointer to an ${obj.type_name} object.
 * @fd: Pointer to a #${prefix}_io_t object where to print @ptr to.
 *
 * This function will convert @ptr to a string suitable for writing,
 * and write it to the provided @fd descriptor.
 */
void ${name_lib}_${obj.short_type_name}_print(${obj.type_name} *ptr, ${prefix}_io_t *fd)
{
        if ( ! ptr )
                return;


% if obj.top_level != 1:
        indent += 8;
% endif

% for field in obj.fields_list :
%if field.data_type == DataType.UNION:
        switch ( ${name_lib}_${obj.short_type_name}_get_${field.var}(ptr) ) {

% for member in field.list_member :

        case ${member.value}:
                print_indent(fd);
                ${prefix}_io_write(fd, "${member.name}:\n", sizeof("${member.name}:\n") - 1);
                ${name_lib}_${member.short_type_name}_print(${name_lib}_${obj.short_type_name}_get_${member.name}(ptr), fd);
                break;

% endfor
        default:
                break;
        }
%elif  field.listed:
        {
                char buf[128];
                ${field.type_name} *elem = NULL;
                int cnt = 0, len;

                while ( (elem = ${name_lib}_${obj.short_type_name}_get_next_${field.short_name}(ptr, elem)) ) {
                        print_indent(fd);
%if field.data_type == DataType.PRIMITIVE or field.data_type == DataType.PRIMITIVE_STRUCT:
                        len = snprintf(buf, sizeof(buf), "${field.short_name}(%d): ", cnt);
                        ${prefix}_io_write(fd, buf, len);
                        print_${field.value_type}(elem, fd);
                        ${prefix}_io_write(fd, "\n", sizeof("\n") - 1);


% else :

                        len = snprintf(buf, sizeof(buf), "${field.short_name}(%d): \n", cnt);
                        ${prefix}_io_write(fd, buf, len);
                        ${name_lib}_${field.short_type_name}_print(elem, fd);

% endif


                        cnt++;
                }
        }
% else: ##normal
<% refer = "*" if field.is_op_int else "" %>
% if  field.data_type == DataType.ENUM:
    {
                int ${refer}i = ${name_lib}_${obj.short_type_name}_get_${field.name}(ptr);


% if field.is_op_int:
                if ( i )
% endif

                {
                        print_indent(fd);
                        ${prefix}_io_write(fd, "${field.name}: ", sizeof("${field.name}: ") - 1);
                        print_enum(${name_lib}_${field.short_type_name}_to_string(${refer}i), ${refer}i, fd);
                        ${prefix}_io_write(fd, "\n", sizeof("\n") - 1);
                }
        }
%elif field.data_type == DataType.PRIMITIVE or field.data_type == DataType.PRIMITIVE_STRUCT:
% if  field.data_type == DataType.STRUCT or field.data_type == DataType.PRIMITIVE_STRUCT or field.is_op_int:
        {
                ${field.type_name} *field;
                const char tmp[] = "${field.name}: ";
                field = ${name_lib}_${obj.short_type_name}_get_${field.name}(ptr);
                if ( field ) {
                        print_indent(fd);
                        ${prefix}_io_write(fd, tmp, sizeof(tmp) - 1);
% if obj.short_type_name == "additional_data" and field.type_name == name_lib + "_data_t" :
                        if ( ${name_lib}_additional_data_get_type(ptr) != ${name_lib.upper()}_ADDITIONAL_DATA_TYPE_NTPSTAMP )
                                print_${field.value_type}(${refer}field, fd);
                        else {
                                int ret;
                                uint64_t i;
                                ${prefix}_string_t *out;

                                ret = ${prefix}_string_new(&out);
                                if ( ret < 0 )
                                        return;

                                i = ${name_lib}_data_get_int(field);
                                ret = ${prefix}_string_sprintf(out, "0x%" ${prefix.upper()}_PRIx32 ".0x%" ${prefix.upper()}_PRIx32 "", (uint32_t) (i >> 32), (uint32_t) i);
                                if ( ret < 0 ) {
                                        ${prefix}_string_destroy(out);
                                        return;
                                }

                                ${prefix}_io_write(fd, ${prefix}_string_get_string(out), ${prefix}_string_get_len(out));
                                ${prefix}_string_destroy(out);
                        }
% else :
                        print_${field.value_type}(${refer}field, fd);
% endif
                        ${prefix}_io_write(fd, "\n", sizeof("\n") - 1);
                }
        }


% else :

        print_indent(fd);
        ${prefix}_io_write(fd, "${field.name}: ", sizeof("${field.name}: ") - 1);
        print_${field.value_type}(${name_lib}_${obj.short_type_name}_get_${field.name}(ptr), fd);
        ${prefix}_io_write(fd, "\n", sizeof("\n") - 1);
% endif
% elif  field.data_type == DataType.STRUCT or field.data_type == DataType.PRIMITIVE_STRUCT:
        {
                ${field.type_name} *field;

                field = ${name_lib}_${obj.short_type_name}_get_${field.name}(ptr);

                if ( field ) {
                        print_indent(fd);
                        ${prefix}_io_write(fd,  "${field.name}:\n", sizeof("${field.name}:\n") - 1);
                        ${name_lib}_${field.short_type_name}_print(field, fd);
                }
        }
% endif
% endif ## normal_end
% endfor ## field_list

% if obj.top_level != 1:
        indent -= 8;
% endif
}
% endif ## struct_end
% endfor ## end of iteration over obj_list