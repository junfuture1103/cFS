/************************************************************************
 * NASA Docket No. GSC-18,719-1, and identified as “core Flight System: Bootes”
 *
 * Copyright (c) 2020 United States Government as represented by the
 * Administrator of the National Aeronautics and Space Administration.
 * All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License. You may obtain
 * a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ************************************************************************/

/******************************************************************************
 *  Message id access functions, cFS version 1 implementation
 */
#include "cfe_msg.h"
#include "cfe_msg_priv.h"
#include "cfe_error.h"
#include "cfe_platform_cfg.h"
#include "cfe_sb.h"
#include "cfe_es.h"

/*----------------------------------------------------------------
 *
 * Implemented per public API
 * See description in header file for argument/return detail
 *
 *-----------------------------------------------------------------*/
CFE_Status_t CFE_MSG_GetMsgId(const CFE_MSG_Message_t *MsgPtr, CFE_SB_MsgId_t *MsgId)
{
    CFE_SB_MsgId_Atom_t msgidval;

    if (MsgPtr == NULL || MsgId == NULL)
    {
        return CFE_MSG_BAD_ARGUMENT;
    }

    msgidval = (MsgPtr->CCSDS.Pri.StreamId[0] << 8) + MsgPtr->CCSDS.Pri.StreamId[1];
    *MsgId   = CFE_SB_ValueToMsgId(msgidval);

    // 로그 추가 by juntheworld
    // CFE_ES_WriteToSysLog("CFE_MSG_GetMsgId          : StreamId[0]=0x%02X, StreamId[1]=0x%02X, msgidval=0x%04X, Sequence=0x%02X%02X, Length=0x%02X%02X\n",
    //                      MsgPtr->CCSDS.Pri.StreamId[0],
    //                      MsgPtr->CCSDS.Pri.StreamId[1],
    //                      msgidval,
    //                      MsgPtr->CCSDS.Pri.Sequence[0],
    //                      MsgPtr->CCSDS.Pri.Sequence[1],
    //                      MsgPtr->CCSDS.Pri.Length[0],
    //                      MsgPtr->CCSDS.Pri.Length[1]
    //                      );

    return CFE_SUCCESS;
}

/*----------------------------------------------------------------
 *
 * Implemented per public API
 * See description in header file for argument/return detail
 *
 *-----------------------------------------------------------------*/
CFE_Status_t CFE_MSG_SetMsgId(CFE_MSG_Message_t *MsgPtr, CFE_SB_MsgId_t MsgId)
{
    CFE_SB_MsgId_Atom_t msgidval = CFE_SB_MsgIdToValue(MsgId);

    if (MsgPtr == NULL || !CFE_SB_IsValidMsgId(MsgId))
    {
        return CFE_MSG_BAD_ARGUMENT;
    }

    /* Shift and mask bytes to be endian agnostic */
    MsgPtr->CCSDS.Pri.StreamId[0] = (msgidval >> 8) & 0xFF;
    MsgPtr->CCSDS.Pri.StreamId[1] = msgidval & 0xFF;

    return CFE_SUCCESS;
}