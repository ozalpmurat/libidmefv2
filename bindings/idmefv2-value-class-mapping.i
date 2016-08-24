
/*****
*
* Copyright (C) 2005-2016 CS-SI. All Rights Reserved.
* Author: Yoann Vandoorselaere <yoann.v@libidmefv2-ids.com>
*
* This file is part of the Libidmefv2 library.
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

/* generated by the idmefv2-value-class-swig-mapping.i.mako template */


%{

void *swig_idmefv2_value_get_descriptor(idmefv2_value_t *value)
{
        unsigned int i = 0;
        idmefv2_class_id_t wanted_class = idmefv2_value_get_class(value);
	const struct {
	        idmefv2_class_id_t class;
	        const char *typename;
	} tbl[] = {
                  { IDMEFV2_CLASS_ID_ACTION, "idmefv2_action_t *" },
                  { IDMEFV2_CLASS_ID_ADDRESS, "idmefv2_address_t *" },
                  { IDMEFV2_CLASS_ID_USER_ID, "idmefv2_user_id_t *" },
                  { IDMEFV2_CLASS_ID_NODE_NAME, "idmefv2_node_name_t *" },
                  { IDMEFV2_CLASS_ID_LOCATION, "idmefv2_location_t *" },
                  { IDMEFV2_CLASS_ID_INTERFACE, "idmefv2_interface_t *" },
                  { IDMEFV2_CLASS_ID_FILE_ACCESS, "idmefv2_file_access_t *" },
                  { IDMEFV2_CLASS_ID_INODE, "idmefv2_inode_t *" },
                  { IDMEFV2_CLASS_ID_CHECKSUM, "idmefv2_checksum_t *" },
                  { IDMEFV2_CLASS_ID_STREAM, "idmefv2_stream_t *" },
                  { IDMEFV2_CLASS_ID_FILE, "idmefv2_file_t *" },
                  { IDMEFV2_CLASS_ID_LINKAGE, "idmefv2_linkage_t *" },
                  { IDMEFV2_CLASS_ID_CONTAINER, "idmefv2_container_t *" },
                  { IDMEFV2_CLASS_ID_SNMP_SERVICE, "idmefv2_snmp_service_t *" },
                  { IDMEFV2_CLASS_ID_WEB_SERVICE, "idmefv2_web_service_t *" },
                  { IDMEFV2_CLASS_ID_PROCESS, "idmefv2_process_t *" },
                  { IDMEFV2_CLASS_ID_SERVICE, "idmefv2_service_t *" },
                  { IDMEFV2_CLASS_ID_NODE, "idmefv2_node_t *" },
                  { IDMEFV2_CLASS_ID_USER, "idmefv2_user_t *" },
                  { IDMEFV2_CLASS_ID_IMPACT_TYPE, "idmefv2_impact_type_t *" },
                  { IDMEFV2_CLASS_ID_SOURCE, "idmefv2_source_t *" },
                  { IDMEFV2_CLASS_ID_TARGET, "idmefv2_target_t *" },
                  { IDMEFV2_CLASS_ID_ORIGINAL_DATA, "idmefv2_original_data_t *" },
                  { IDMEFV2_CLASS_ID_OBSERVABLE, "idmefv2_observable_t *" },
                  { IDMEFV2_CLASS_ID_TAKEN_ACTION, "idmefv2_taken_action_t *" },
                  { IDMEFV2_CLASS_ID_REFERENCE, "idmefv2_reference_t *" },
                  { IDMEFV2_CLASS_ID_ANALYZER, "idmefv2_analyzer_t *" },
                  { IDMEFV2_CLASS_ID_ADDITIONAL_DATA, "idmefv2_additional_data_t *" },
                  { IDMEFV2_CLASS_ID_CORRELATION_ALERT, "idmefv2_correlation_alert_t *" },
                  { IDMEFV2_CLASS_ID_ANALYSIS_DATA, "idmefv2_analysis_data_t *" },
                  { IDMEFV2_CLASS_ID_CONFIDENCE, "idmefv2_confidence_t *" },
                  { IDMEFV2_CLASS_ID_IMPACT, "idmefv2_impact_t *" },
                  { IDMEFV2_CLASS_ID_RECOMMANDED_ACTION, "idmefv2_recommanded_action_t *" },
                  { IDMEFV2_CLASS_ID_ASSESSMENT, "idmefv2_assessment_t *" },
                  { IDMEFV2_CLASS_ID_CLASSIFICATION, "idmefv2_classification_t *" },
                  { IDMEFV2_CLASS_ID_HEARTBEAT, "idmefv2_heartbeat_t *" },
                  { IDMEFV2_CLASS_ID_TOOL_ALERT, "idmefv2_tool_alert_t *" },
                  { IDMEFV2_CLASS_ID_OVERFLOW_ALERT, "idmefv2_overflow_alert_t *" },
                  { IDMEFV2_CLASS_ID_ALERT, "idmefv2_alert_t *" },
                  { IDMEFV2_CLASS_ID_MESSAGE, "idmefv2_message_t *" },
                { 0, NULL }
        };

        for ( i = 0; tbl[i].typename != NULL; i++ ) {
                if ( tbl[i].class == wanted_class )
		        return SWIG_TypeQuery(tbl[i].type_name);
        }

        return NULL;
}

%}
