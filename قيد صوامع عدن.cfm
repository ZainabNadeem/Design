<!---THIS REPORT HAD BEEN DEVELOPED BY ENG.ZIAD HUWAIDI and zainab nadeem--->
<!---V21 ADD SERVICE-STAFF (salary per day) AS CATOGERY--->
<!---V22 remove SERVICE-STAFF (salary per day) AS CATOGERY and support report with Table style--->
<!---V23 support report with resend an email action--->
<!---V23 support report with CHANGE REVIEWER OR APPROVAL AND resend an email action--->
<!---V24 change some words and sentences and --->
<!---V25 correct the calc of Gross s.s column --->
<!---V1add new columen of changrate ss --->
<!---V2add adjestmetn column --->
<!---V3add first checkbox --->
<!---Z1 first zineb nadeem work for make sexxion of company in conditions of select puan --->

<cfprocessingdirective pageEncoding="utf-8">
<cfset REVIEWER1_code=''>
<cfset APPROVAL1_code=''>
<cfset APPROVAL2_code=''>  
   <cfset dec_sal_sum=0> 
   <cfset t_dec_sum=0>
    <cfset t_15_sum=0> 
	<cfset t_withour_sum=0>
     <cfset t_col10_sum=0>
	 <cfset t_SSK011_sum = 0>
      <cfset t_col9_sum=0>
<cfparam name="attributes.ADDGL" default="">  
<cfset t_col2_sum=0> 
<cfset t_advance_inn=0>
<cfset Gl_Aden_USD = 0>
   <cfset t_te_aind=0>
 <cfset t_col8_sum=0> 
 <cfset t_col8_sum=0> 
 <cfset t_col14_sum=0> 
 <cfset t_Dedec_Gl1=0>
 <cfset t_Dedec_gl2=0>
 <cfset t_Dedec_gl3=0>
 <cfset t_Dedec_gl4=0>
 <cfset t_Dedec_gl5=0>
 <cfset t_Dedec_gl6=0>
 <cfset t_Dedec_gl7=0>
 <cfset t_Dedec_gl8=0>
 <cfset t_Dedec_gl9=0>
 <cfset t_Dedec_gl10=0>
 <cfset t_Dedec_gl11=0>
 <cfset t_Dedec_g12=0> 
 <cfset One_fimailys_t=0>
 <cfset t_holid_sum= 0>
  <cfset t_col13_sum=0> 
<cfset t_col14_sum=0> 
<cfset total_z =0>
<cfset t_col14_sum=0>
<!-----za_sum------>
<cfset t_salba_sum=0>
<cfset t_Tran_sum=0>
<cfSET t_Rep_sum =0>
<cfset  t_Repres_sum=0>
<cfset  t_nature_sum1 =0>
<cfset t_Grosss_sum=0>
  <cfset t_S.S6_sum=0>
<cfset t_S.S9_sum=0>
<cfSET t_S.Skz1_sum =0>
<cfset t_Satax_sum =0>
< cfset t_SSk_sum=0>
< cfset t_Sal15_sum=0>
< cfset t_15_sum=0>
<cfset t_SSK01_sum = 0>
<cfset t_za_sal_sum=0>
< cfset t_Incom_sum=0>
< cfset t_Incom_sum=0>
<cfset dec_Tax_sum=0>
<cfset dec_oth_sum=0>
<cfset t_dec_sum=0>
<cfset t_Net_sum=0> 
<cfset t_advance_sum= 0>  
<cfset GLins=0>
<cfset GLnet=0>
<cfset GLtax=0>
 <cfset Ded_gl_total= 0>
 <cfparam name="attributes.ADDnet" default="">
<cfparam name="attributes.ADDdetec" default="">
<cfparam name="attributes.ADDAdj" default="">
<cfparam name="attributes.isGL" default="">


<cfquery name="za_Budget_id" datasource="#dsn#">
SELECT top 1 BUDGET_ID FROM [wrk_rgyemen].[wrk_rgyemen].BUDGET
WHERE  OUR_COMPANY_ID=#session.ep.company_id#
order by BUDGET_ID desc

 </cfquery >


<!-------GL Frist instullation 1--------------------->
          <cfset P_BUDGET_PLAN=1 >
            <cfset P_BUDGET_ID=#za_Budget_id.Budget_id# >
          <cfset P_PROCESS_STAGE=9>
		  <cfset P_PROCESS_TYPE=161>
        <!--- most change by account perio---> 	<cfset P_PROCESS_CAT=39 >
		   <cfset P_BUDGET_ITEM_ID_salary = 19 >
		   <cfset P_BUDGET_ACCOUNT_CODE_salary = '100' >
		    <cfset P_BUDGET_ITEM_ID_salary_ss = 24 >
		   <cfset P_BUDGET_ACCOUNT_CODE_salary_ss = '101' >
		    <cfset P_BUDGET_ITEM_ID_salary_ins = 25 >
		   <cfset P_BUDGET_ACCOUNT_CODE_salary_ins = '102' >
		   
		   
		   <cfset P_BUDGET_ITEM_ID_SS=13 >
		   <cfset P_BUDGET_ACCOUNT_CODE_SS='3.1.2.01.01.001'>
           <cfset P_RELATED_EMP_ID_acc_sa=4685 >
		   <cfset P_BUDGET_ACCOUNT_CODE_acc_sa='2.1.1.08.01.001'>
          <cfset P_RELATED_EMP_ID_tax=4687 >
		  <cfset P_BUDGET_ACCOUNT_CODE_tax='2.1.1.04.01.001'>
           <cfset P_RELATED_EMP_ID_insu=4686 >
		   <cfset P_BUDGET_ACCOUNT_CODE_insu='2.1.1.04.01.002'>
<!----------------->	




                              <cfquery name="get_allow_costcenter"  datasource="#dsn2#">
	                           SELECT EXPENSE_id,EXPENSE_BRANCH_ID FROM EXPENSE_CENTER where EXPENSE_ID > = 1 
                               </cfquery>  
		 
		
                               <cfquery name="get_payroll_id" datasource="#dsn#">
	                            SELECT  PAYROLL_ID FROM [SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF]
								where PAYROLL_STATUS=1 and  OUR_COMPANY_ID = #session.ep.company_id#
                                </cfquery>
		
                                  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >

                                <cfset 'gross_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0> 
                                <cfset 'SSK9_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'tr_01_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0> 
								<cfset 'SSK15c_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0> 
								<cfset 'Transportation_allowances_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0> 
								<cfset 'Call_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'Cashier_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'Area_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'Full_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'Incentive_and_Supervision_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'Nature_of_work_control_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'An_incentive_instead_of_risk_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'Feed_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'Nature_of_work_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								<cfset 'Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'=0>
								
							
					
					
                                           </cfloop>
                                                </cfloop>

	  <!---------Gl Connect ------>
   


<!-----------function to match the net-------------->
<cffunction name="getnet" output="false" access="public" returntype="any">
    <cfargument name="empparm" type="string" required="false" default="" />
    
   

	<cfquery name="qcustanly" datasource="#dsn#">
SELECT 

     ((NET_UCRET - (((ISSIZLIK_ISCI_HISSESI + ISSIZLIK_ISVEREN_HISSESI)* DAMGA_VERGISI_INDIRIMI_7103)- ((ISSIZLIK_ISCI_HISSESI + ISSIZLIK_ISVEREN_HISSESI)* GELIR_VERGISI_INDIRIMI_7103)) / DAMGA_VERGISI_INDIRIMI_7103))  AS NET_UCRET_
             
                       
FROM            EMPLOYEES_PUANTAJ_ROWS INNER JOIN
                         EMPLOYEES_PUANTAJ ON EMPLOYEES_PUANTAJ_ROWS.PUANTAJ_ID = EMPLOYEES_PUANTAJ.PUANTAJ_ID 
                        
                          WHERE   
      SAL_MON= #attributes.sal_mon#  
      AND SAL_YEAR= #attributes.sal_YEAR#
     
   
       AND  EMPLOYEES_PUANTAJ_ROWS.EMPLOYEE_ID  = #arguments.empparm#

   
	
	
	
 </cfquery>

	<cfreturn   qcustanly />
																
	
	
	</cffunction>
	
	
	
						  

<!-----------create with  FULL  conditions the function  for salary-------------->
						 
		<cfif isdefined('attributes.resend_email')>
	   
  
													

<cffunction name="msgg">
<cfargument name="RECEIVER_ID" required="true">
        <cfargument name="POSITION_CODE" required="true">
        <cfargument name="WARNING_HEAD" required="true">
<cfif len(RECEIVER_ID)>
        <cfquery name="get_employee_data" datasource="#dsn#">
           SELECT        
              EMPLOYEE_NAME, 
              EMPLOYEE_SURNAME, 
              EMPLOYEE_EMAIL,
              (SELECT TOP (1) EMPLOYEE_EMAIL FROM EMPLOYEES WHERE EMPLOYEE_ID=#SESSION.EP.USERID#) AS SENDER
              FROM   EMPLOYEES
              WHERE        (EMPLOYEE_ID = #RECEIVER_ID#)
        </cfquery>
        
         
		<cfif ISDEFINED('attributes.W_ID_') AND LEN (attributes.W_ID_)>
        
		<cfquery name="Get_Max_Warnings" datasource="#dsn#">
        UPDATE 
        PAGE_WARNINGS
        SET IS_ACTIVE=1,
        EMAIL_WARNING_DATE=#now()#
        where W_ID=#attributes.W_ID_#
        
		SELECT #attributes.W_ID_# AS MAX
        </cfquery>
        <cfelse>
        <cfquery name="Get_Maxi_Paper" datasource="#dsn#">
			SELECT  MAX(PAPER_NO) PAPER_NO FROM PAGE_WARNINGS 
		</cfquery>
        
		<cfif Get_Maxi_Paper.RecordCount and len(Get_Maxi_Paper.Paper_No)>
			<cfset Maxi = Get_Maxi_Paper.Paper_No + 1>
		<cfelse>
			<cfset Maxi = 1>
		</cfif>
        <cfquery name="add_Page_Warnings" datasource="#dsn#">
        DELETE FROM PAGE_WARNINGS WHERE WARNING_HEAD=N'#REPLACE(attributes.REPORT_NAME,"KOA","Master PAYROLL","all")#' AND SETUP_WARNING_ID=<cfif isdefined('attributes.type')>#attributes.type#<cfelse>-2</cfif>
        INSERT INTO
				PAGE_WARNINGS
			(
				PAPER_NO,
				URL_LINK,
				WARNING_HEAD,
				SETUP_WARNING_ID,
				WARNING_DESCRIPTION,
				SMS_WARNING_DATE,
				EMAIL_WARNING_DATE,
				LAST_RESPONSE_DATE,
				RECORD_DATE,
				IS_ACTIVE,
				IS_PARENT,
				RESPONSE_ID,
				RECORD_IP,
				RECORD_EMP,
				POSITION_CODE,
				WARNING_PROCESS,
				OUR_COMPANY_ID,
				PERIOD_ID,
				ACTION_TABLE,
				ACTION_COLUMN,
				ACTION_ID,
				ACTION_STAGE_ID
			)
		VALUES
			(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#Maxi#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#request.self#?fuseaction=report.popupflush_view_saved_report&sr_id=#attributes.SR_ID#">,
				N'#REPLACE(attributes.REPORT_NAME,"KOA","Master PAYROLL","all")#',
                <cfif isdefined('attributes.type')>#attributes.type#<cfelse>-2</cfif>,
				N'Please check the report for approving',
				#NOW()#,
				#NOW()#,
				#NOW()#,
                #NOW()#,
				1,
				1,
				0,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.remote_addr#">,
				#session.ep.USERID#,
				#POSITION_CODE#,
				1,
				#SESSION.EP.company_id#,
				#SESSION.EP.period_id#,
				'SAVED_REPORTS',
				'SR_ID',
				#attributes.SR_ID#,
				0
			)
		</cfquery>
        <cfquery name="Get_Max_Warnings" datasource="#dsn#">
			SELECT MAX(W_ID) MAX FROM PAGE_WARNINGS
		</cfquery>
        <cfquery name="Upd_Warnings" datasource="#dsn#">
			UPDATE PAGE_WARNINGS SET PARENT_ID = #Get_Max_Warnings.Max# WHERE W_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Max_Warnings.Max#">
		</cfquery>
        </cfif>
        
			<cfset sender =session.ep.company_email>
        <cfif len(get_employee_data.SENDER) and find('.org',get_employee_data.SENDER)>
		
		<cfset sender =get_employee_data.SENDER>
        
        </cfif>
        
		
		
        <cfoutput>
        <cfif get_employee_data.recordcount and  len(get_employee_data.EMPLOYEE_EMAIL)>
        <cfmail to="#get_employee_data.EMPLOYEE_EMAIL#"
			from="#session.ep.company#<#sender#>"
			subject="re-send #Replace(attributes.REPORT_NAME,'KOA','Master Payroll')#" type="HTML">
			عزيزي #get_employee_data.employee_name# #get_employee_data.employee_surname#,
			<br/><br/>
			الرجاء الضغط على الرابط أدناه للوصول إلى ومراجعة#Replace(attributes.REPORT_NAME,'KOA','Master Payroll')# تقرير ...    <br/><br/>
			<a href="#employee_domain##request.self#?fuseaction=report.popupflush_view_saved_report&sr_id=#attributes.SR_ID#" target="_blank"><strong>#Replace(attributes.REPORT_NAME,'KOA','Master Payroll')# تقرير</strong></a> <br/><br/>
            <cfif isdefined('type') AND TYPE EQ -10>
            
            <cfelse>
           للموافقة ، يرجى النقر على الرابط أدناه
				<br/><br/>
               <cfset parent_id_ = contentEncryptingandDecodingAES(isEncode:1,content:Get_Max_Warnings.Max,accountKey:'wrk')>
			  <cfset w_id_ = contentEncryptingandDecodingAES(isEncode:1,content:Get_Max_Warnings.Max,accountKey:'wrk')>
              <a href="#employee_domain##request.self#?fuseaction=myhome.popup_dsp_warning&warning_id=#w_id_#&warning_is_active=1&sub_warning_id=#parent_id_#" target="_blank"><strong>#Replace(attributes.REPORT_NAME,'KOA','Master Payroll')# حالة الموافقة </strong></a>
            <br/><br/>
			في حالة حدوث أي مشكلة ، يرجى الاتصال بمديرية الموارد البشرية بالمقر الرئيسي
            </cfif>
            <br/><br/>
            ملاحظة: - تم إرسال هذا البريد من  <strong>نظام تخطيط موارد المؤسسات NMF</strong><br/>
			ملاحظة 2: - يرجى عدم الرد على هذا البريد الإلكتروني
		</cfmail>
        </cfif>
         <cfmail to="#sender#"
           from="#session.ep.company#<#session.ep.company_email#>"
			subject="Statuts of sending email for re-send #Replace(attributes.REPORT_NAME,'KOA','Master Payroll')#" type="HTML">
			Dear #get_emp_info(session.ep.POSITION_CODE,1,0)#,
			<br/><br/>
			حسب الموضوع تجدون القائمة أدناه: -   <br/><br/>
			<cfif get_employee_data.recordcount and  len(get_employee_data.EMPLOYEE_EMAIL)>
             #get_employee_data.employee_name#(#get_employee_data.EMPLOYEE_EMAIL#)- أرسلت<br/>
            <cfelseif get_employee_data.recordcount>
            <font color=red>#get_employee_data.employee_name#(#get_employee_data.EMPLOYEE_EMAIL#)- لم ترسل</font><br/>
            </cfif>
            ملاحظة: - تم إرسال هذا البريد من <strong>نظام تخطيط موارد المؤسسات من NMF</strong><br/>
		</cfmail>
        </cfoutput>
</cfif>
</cffunction>

<cfif not isdefined('attributes.POSITION_CODE') or (isdefined('attributes.POSITION_CODE') and not len(attributes.POSITION_CODE))>
<script>
		  alert('Sorry the EMPLOYEE you need to send to is not defined!');
		  window.close();
		  </script>
</cfif>
<cfif isdefined('attributes.SR_ID') and len(attributes.SR_ID)>
<cfquery name="get_report" datasource="#DSN#">
SELECT  
       SR_ID
FROM SAVED_REPORTS
where SR_ID=#attributes.SR_ID#
</cfquery>
<cfif not get_report.recordcount>
<script>
		  alert('Sorry the closed report had removed \n please re-close the report');
		   if (window.opener != null && !window.opener.closed)
		  {
			 window.opener.re();
		  }
		  window.close();
		  </script>
          </cfif>
<cfelse>
<script>
		  alert('Sorry the closed report is not AV\n please re-close the report');
		   if (window.opener != null && !window.opener.closed)
		  {
			 window.opener.re();
		  }
		  window.close();
		  </script>
</cfif>

<cfquery name="get_pos" datasource="#DSN#">
SELECT  
        POSITION_CODE,
        EMPLOYEE_ID,
        EMPLOYEE_NAME,
        POSITION_NAME,
        DEPARTMENT_ID,
        (SELECT TOP(1) EMPLOYEE_EMAIL FROM EMPLOYEES WHERE EMPLOYEE_ID=EMPLOYEE_POSITIONS.EMPLOYEE_ID) EMAIL
FROM EMPLOYEE_POSITIONS
where POSITION_CODE=#attributes.POSITION_CODE#
</cfquery>
		<cfoutput query="get_pos">
        <cfif LEN(EMAIL) AND FIND('nternational',EMAIL)>
        <cfscript>
        msgg(EMPLOYEE_ID,POSITION_CODE,'#attributes.REPORT_NAME#');
        </cfscript>
        <cfelse>
         <script>
		  alert('Sorry the email of #get_emp_info(attributes.POSITION_CODE,1,0)# is not available or not a member of IMC Email\n Please contact the HR');
		  window.close();
		  </script>
          </cfif>
        </cfoutput>
   <script>
		  if (window.opener != null && !window.opener.closed)
		  {
			 window.opener.re();
		  }
		  window.close();
		  </script>
</cfif>
<cfif isdefined('attributes.reger_service')>
      <cfquery name="GET_NO_ALLOCATION" datasource="#DSN#">
      SELECT DISTINCT ALLOCATION_NO,ALLOCATION_NAME
        FROM 
        ALLOCATION_PLAN
        WHERE
            ALLOCATION_MONTH=#attributes.sal_mon# AND
            ALLOCATION_YEAR=#attributes.sal_year#
       
        </cfquery>
        
      <cfquery name="GET_ALLOCATION_PROJECT" datasource="#DSN#">
      SELECT DISTINCT ALLOCATION_NO,ALLOCATION_NAME,#attributes.BRANCH_ID# AS BRANCH_ID
        FROM 
        ALLOCATION_PLAN
        WHERE
            ALLOCATION_MONTH=#attributes.sal_mon# AND
            ALLOCATION_YEAR=#attributes.sal_year# AND
			ALLOCATION_PLAN.EMP_ID IN(#attributes.Get_PROGRAM#)
        order by ALLOCATION_NAME
       
        </cfquery>
        <cfif GET_ALLOCATION_PROJECT.RECORDCOUNT>
        <cfset BID=0>
        
          <cfoutput  query="GET_ALLOCATION_PROJECT">
          <cfif BID NEQ BRANCH_ID>
               <cfset Get_GNRL_RATE=LISTLEN(attributes.Get_PROGRAM)>
               <cfset Get_SUM_EMP=LISTLEN(attributes.Get_SERVICE)>
                   <cfset BID = BRANCH_ID>
                   <cfset TOTAL_GEMP_NO=Get_GNRL_RATE>
                   <cfset TOTAL_SER_EMP_NO=Get_SUM_EMP>
                   </cfif>
        	   <cfquery name="Get_SUM_RATE" datasource="#DSN#">
                      SELECT SUM(ALLOCATION_PLAN.RATE) RATE
                      FROM 
                      ALLOCATION_PLAN
                      WHERE
                          ALLOCATION_MONTH=#attributes.sal_mon# AND
                          ALLOCATION_YEAR=#attributes.sal_year# AND
                          EMP_ID IN(#attributes.Get_PROGRAM#) AND 
                          ALLOCATION_NO LIKE N'#ALLOCATION_NO#' AND 
                          ALLOCATION_NAME LIKE N'#ALLOCATION_NAME#'
                   </cfquery>
                   
              <cfif Get_SUM_RATE.RECORDCOUNT AND Get_SUM_RATE.RATE neq 0  AND Get_SUM_EMP neq 0> 
              
                <cfset TOTL_RATE1=evaluate('#tlformat(Get_SUM_RATE.RATE/TOTAL_GEMP_NO,0)#')>
                  
                 <cfquery datasource="#DSN#">
                      UPDATE  ALLOCATION_PLAN
                      SET RATE= #TOTL_RATE1#
                      FROM 
                      ALLOCATION_PLAN
                      WHERE
                          ALLOCATION_MONTH=#attributes.sal_mon# AND
                          ALLOCATION_YEAR=#attributes.sal_year# AND
                          EMP_ID IN(#attributes.Get_SERVICE#)
                      AND ALLOCATION_NO LIKE N'#ALLOCATION_NO#'
                      AND ALLOCATION_NAME LIKE N'#ALLOCATION_NAME#'
              </cfquery>
             
              <cfelse>
              <cfquery datasource="#DSN#">
                UPDATE       ALLOCATION_PLAN
                SET               RATE=0
                FROM 
                      ALLOCATION_PLAN
                         WHERE
                          ALLOCATION_MONTH=#attributes.sal_mon# AND
                          ALLOCATION_YEAR=#attributes.sal_year# AND
                          EMP_ID IN(#attributes.Get_SERVICE#)
                      AND ALLOCATION_NO LIKE N'#ALLOCATION_NO#'
                      AND ALLOCATION_NAME LIKE N'#ALLOCATION_NAME#'
              </cfquery>
            </cfif>
          </cfoutput>
          
          DONE....
          
        <cfelse>
         عذرا ، البيانات المطلوبة غير متوفرة <br />يرجى التحقق مما إذا تم تحميل ملف  LOE للشهر المحدد .. 
        </cfif>
  <script>
		  if (window.opener != null && !window.opener.closed)
		  {
			 window.opener.re();
		  }
		  window.close();
		  </script>
<cfelse>
<cfparam name="attributes.emp_id" default="">
<cfparam name="attributes.emp_name" default="">
<cfparam name="attributes.branch_id" default="">
<cfparam name="attributes.sal_mon" default="#MONTH(NOW())#">
<cfparam name="attributes.sal_year" default="#session.ep.period_year#">
<cfparam name="attributes.DEPARTMENT_ID" default="">
<cfparam name="attributes.Type_id" default="1">
<cfparam name="attributes.Gross_with_adjust" default="">
<cfparam name="attributes.Table" default="1">
<cfparam name="attributes.with_color" default="">
<cfparam name="attributes.new_staff" default="">
<cfparam name="attributes.changed_staff" default="">
<cfparam name="attributes.FUNC" default="">
<cfparam name="attributes.Grant_option" default="1,2,3">
<cfparam name="attributes.Grant" default="">
<cfparam name="attributes.col_option" default="">
<cfparam name="attributes.DepartmentXX" default="">
<cfparam name="attributes.Position" default="">
<cfparam name="attributes.Staff_ID" default="">
<cfparam name="attributes.Accounts" default="">


<cfparam name="attributes.DISTRIBUTION" default="">
<cfparam name="attributes.REVIEWER1_id" default="">
<cfparam name="attributes.REVIEWER1_name" default="">

<cfparam name="attributes.REVIEWER2_id" default="">
<cfparam name="attributes.REVIEWER2_name" default="">
<cfparam name="attributes.APPROVAL1_id" default="">
<cfparam name="attributes.APPROVAL1_name" default="">

<cfparam name="attributes.APPROVAL2_id" default="">
<cfparam name="attributes.APPROVAL2_name" default="">

<cfsavecontent variable="ay1"><cf_get_lang_main no='180.Ocak'></cfsavecontent>
<cfsavecontent variable="ay2"><cf_get_lang_main no='181.Şubat'></cfsavecontent>
<cfsavecontent variable="ay3"><cf_get_lang_main no='182.Mart'></cfsavecontent>
<cfsavecontent variable="ay4"><cf_get_lang_main no='183.Nisan'></cfsavecontent>
<cfsavecontent variable="ay5"><cf_get_lang_main no='184.Mayıs'></cfsavecontent>
<cfsavecontent variable="ay6"><cf_get_lang_main no='185.Haziran'></cfsavecontent>
<cfsavecontent variable="ay7"><cf_get_lang_main no='186.Temmuz'></cfsavecontent>
<cfsavecontent variable="ay8"><cf_get_lang_main no='187.Ağustos'></cfsavecontent>
<cfsavecontent variable="ay9"><cf_get_lang_main no='188.Eylül'></cfsavecontent>
<cfsavecontent variable="ay10"><cf_get_lang_main no='189.Ekim'></cfsavecontent>
<cfsavecontent variable="ay11"><cf_get_lang_main no='190.Kasım'></cfsavecontent>
<cfsavecontent variable="ay12"><cf_get_lang_main no='191.Aralık'></cfsavecontent>
<cfset ay_list = "#ay1#,#ay2#,#ay3#,#ay4#,#ay5#,#ay6#,#ay7#,#ay8#,#ay9#,#ay10#,#ay11#,#ay12#">
<cfset attributes.sal_year_end=attributes.SAL_YEAR>
<cfset attributes.sal_mon_end=attributes.sal_mon>
<cfif not len(attributes.APPROVAL2_name)><cfset attributes.APPROVAL2_id =""></cfif>
<cfif not len(attributes.APPROVAL1_name)><cfset attributes.APPROVAL1_id =""></cfif>

<cfif not len(attributes.REVIEWER1_name)><cfset attributes.REVIEWER1_id =""></cfif>
<cfif not len(attributes.REVIEWER2_name)><cfset attributes.REVIEWER2_id =""></cfif>

 <cfif len(attributes.REVIEWER1_id) and len(attributes.REVIEWER1_name)>
            <cfquery name="get_code" datasource="#DSN#">
         SELECT POSITION_CODE
         FROM EMPLOYEE_POSITIONS
         where EMPLOYEE_ID =#attributes.REVIEWER1_id#
          </cfquery>
          <cfif get_code.RECORDCOUNT>
            <cfset REVIEWER1_code=get_code.POSITION_CODE>
          </cfif>
        </cfif>
        
        <cfif len(attributes.APPROVAL1_id) and len(attributes.APPROVAL1_name)>
            <cfquery name="get_code" datasource="#DSN#">
         SELECT POSITION_CODE
         FROM EMPLOYEE_POSITIONS
         where EMPLOYEE_ID =#attributes.APPROVAL1_id#
          </cfquery>
          <cfif get_code.RECORDCOUNT>
            <cfset APPROVAL1_code=get_code.POSITION_CODE>
          </cfif>
        </cfif>
        <cfif len(attributes.APPROVAL2_id) and len(attributes.APPROVAL2_name)>
            <cfquery name="get_code" datasource="#DSN#">
         SELECT POSITION_CODE
         FROM EMPLOYEE_POSITIONS
         where EMPLOYEE_ID =#attributes.APPROVAL2_id#
          </cfquery>
          <cfif get_code.RECORDCOUNT>
            <cfset APPROVAL2_code=get_code.POSITION_CODE>
          </cfif>
        </cfif>

<cfif attributes.sal_mon eq 1>
				<cfset Prev_MON=12>
                <cfset Prev_YEAR=attributes.SAL_YEAR-1>
                <cfelse>
                <cfset Prev_MON=attributes.sal_mon-1>
                <cfset Prev_YEAR=attributes.SAL_YEAR>
                </cfif>
<cfif attributes.Table eq 2>
<cfset coloption=2>
<cfelse>
<cfset coloption=3>
</cfif>
 <cfif len(attributes.Grant_option) and  attributes.Table neq 2> 
  <cfset coloption=listlen(attributes.Grant_option)>
 </cfif>
<cfquery name="ALLOCATION_" datasource="#DSN#">
SELECT DISTINCT ALLOCATION_NO,ALLOCATION_NAME
FROM 
ALLOCATION_PLAN
ORDER BY ALLOCATION_NAME
</cfquery>
<cfif len(attributes.Type_id) and attributes.Type_id eq 5>
   
</cfif>
<cfform name="form" method="post" action="#request.self#?fuseaction=report.detail_report&report_id=#attributes.report_id#&event=det">
<input name="is_form_submitted" id="is_form_submitted" type="hidden" value="1">
<cfif len(attributes.Type_id) and attributes.Type_id eq 5>
<input name="rep_name" id="rep_name" type="hidden" value="KOA">
<input name="KOA" id="KOA" type="hidden" value="1">
<cfelseif len(attributes.Type_id) and attributes.Type_id eq 1>
<input name="rep_name" id="rep_name" type="hidden" value="SERVICE">
<input name="SERVICE" id="SERVICE" type="hidden" value="1">
</cfif>
<cf_basket_form id="gizli">
<div style="text-align:left">
<select name="sal_mon" id="sal_mon" style="width:75px;">
						<cfloop from="1" to="12" index="i">
						  <cfoutput><option value="#i#" <cfif attributes.sal_mon is i>selected</cfif> >#listgetat(ay_list,i,',')#</option></cfoutput>
						</cfloop>
		</select>
					<select name="sal_year" id="sal_year">
						<cfloop from="#session.ep.period_year#" to="#session.ep.period_year-3#" step="-1" index="i">
							<cfoutput><option value="#i#"<cfif attributes.sal_year eq i> selected</cfif>>#i#</option></cfoutput>
						</cfloop>
					</select>  <cf_wrk_search_button>
       <BR /><BR />

<strong>
المكتب الفرعي
</strong>   
<cfquery name="get_branch" datasource="#dsn#">
SELECT * FROM BRANCH WHERE BRANCH_STATUS = 1 and company_id='#session.ep.company_id#' ORDER BY BRANCH_ID
</cfquery>    
<cfquery name="getdepartment" datasource="#DSN#">
	SELECT distinct DEPARTMENT_HEAD FROM DEPARTMENT ORDER BY DEPARTMENT_HEAD
</cfquery>                    .
<cfset OZEL_KOD='#get_branch.OZEL_KOD#'>
<select name="branch_id" id="branch_id" style="width:160px;" onChange="">
<option value="" selected>الكـــل</option>
                    <cfoutput query="get_branch">
					<option value="#branch_id#" <cfif len(attributes.branch_id) and attributes.branch_id eq branch_id>selected<cfset OZEL_KOD='#OZEL_KOD#'></cfif>>#branch_id# - #branch_name#</option>
					</cfoutput>
                </select>
                        
  <span style="width:120px">
  <input name="Gross_with_adjust" type="checkbox" id="Gross_with_adjust"<cfif isdefined('attributes.Gross_with_adjust') AND LEN(attributes.Gross_with_adjust)>checked </cfif>  />
  أضف إجمالي إلى التعديل لحساب تخصيص الراتب </span><br />  
  <br />
<strong>
نوع التقرير  
</strong>    <select name="Type_id" id="Type_id" style="width:160px;" onchange="state_color(this.value);">
              <option value="5" <cfif len(attributes.Type_id) and attributes.Type_id eq 5>selected</cfif>>الرواتب الرئيسية</option>
              <option value="3" <cfif len(attributes.Type_id) and attributes.Type_id eq 3>selected</cfif>>ملخص KOA</option>
             
                </select>
<div id="collr" style="">
<input name="with_color" type="hidden" id="with_color" value="1"/> 
 <cfquery name="get_FUNC" datasource="#dsn#">
SELECT 
    	UNIT_ID, 
        UNIT_NAME, 
        HIERARCHY,
        UNIT_DETAIL
    FROM 
	    SETUP_CV_UNIT 
    ORDER BY 
    	UNIT_ID
</cfquery>
<table align="Right" dir="rtl">
    	<tr>
        	<td colspan="4"><strong>إظهار الخيارات</strong></td></tr>
            <tr><td style="width:120px"><select name="col_option" id="col_option" style="width:65px;height:50px;" multiple>
		<option value="1" <cfif ListFind(attributes.col_option,1,',')>selected</cfif>>حصة المؤسسة في التأمين</option>
        <option value="2" <cfif ListFind(attributes.col_option,2,',')>selected</cfif>>التأمين</option>
        <option value="3" <cfif ListFind(attributes.col_option,3,',')>selected</cfif>>ضريبة</option>
                </select>
           </td><td style="width:120px">
             <select name="Grant_option" id="Grant_option" style="width:65px;height:50px;" multiple>
		<option value="1" <cfif ListFind(attributes.Grant_option,1,',')>selected</cfif>>%</option>
        <option value="2" <cfif ListFind(attributes.Grant_option,2,',')>selected</cfif>>الراتب</option>
        <option value="3" <cfif ListFind(attributes.Grant_option,3,',')>selected</cfif>>اجتماعي</option>
                </select>
            </td>
             <td  hidden style="width:120px">   
			 
			 <input  hidden name="ADDGL" type="checkbox" id="ADDGL"<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL)>checked </cfif>  /> اكرميات رمضان
			 
			   
			 
			   <td style="width:120px">    
			 <input name="ADDdetec" type="checkbox" id="ADDdetec"<cfif isdefined('attributes.ADDdetec') AND LEN(attributes.ADDdetec)>checked </cfif>  /><strong> تفصيل السلف </strong>
			 
			 </td> 
			 
			 
			   <td hidden style="width:120px">    
			 <input hidden name="ADDADj" type="checkbox" id="ADDdetec"<cfif isdefined('attributes.ADDAdj') AND LEN(attributes.ADDAdj)>checked </cfif>  /> فرق الضبط
			 
			 </td>
			  
		 
             <td style="width:120px">  
		
			
			     <cfquery name="get_budget_row" datasource="#dsn#">
                 SELECT * FROM BUDGET_PLAN where PAPER_NO like 'BUGSAL01_#attributes.sal_mon##attributes.sal_year#'
                 and  OUR_COMPANY_ID= #session.ep.company_id#
                 </cfquery>
				 
               
				
               <cfif get_budget_row.recordcount eq 0>
                   <input name="ADDGL" type="checkbox" id="ADDGL" /><strong> انشاء القيد المحاسبي </strong>
                  <!--- <script> alert('<cfoutput>تم انشاء القيد</cfoutput>');</script>--->
                 </cfif>
				 
				 

<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL)>
					<cfoutput>	
	         <cfquery name="INSERT_Budget" datasource="#dsn#" result="MAX_ID">
	        INSERT INTO [BUDGET_PLAN]     ([BUDGET_ID]    ,[PROCESS_STAGE]        ,[PROCESS_TYPE]
                                      ,[PROCESS_CAT]             ,[PAPER_NO]            ,[BUDGET_PLAN_DATE]
           ,[BUDGET_PLANNER_EMP_ID]            ,[DETAIL]            ,[INCOME_TOTAL]            ,[EXPENSE_TOTAL]
           ,[DIFF_TOTAL]            ,[INCOME_TOTAL_2]            ,[EXPENSE_TOTAL_2]            ,[DIFF_TOTAL_2]
           ,[OTHER_INCOME_TOTAL]            ,[OTHER_EXPENSE_TOTAL]            ,[OTHER_DIFF_TOTAL]            ,[OTHER_MONEY]
           ,[IS_SCENARIO]            ,[RECORD_EMP]            ,[RECORD_DATE]            ,[RECORD_IP]            ,[UPDATE_EMP]
           ,[UPDATE_DATE]            ,[UPDATE_IP]            ,[ACC_DEPARTMENT_ID]             ,[PERIOD_ID]            ,[OUR_COMPANY_ID]
           ,[UPD_STATUS]            ,[DOCUMENT_TYPE]             ,[PAYMENT_METHOD]            ,[DUE_DATE] 		    )
     VALUES
           ( #P_BUDGET_ID#             ,#P_PROCESS_STAGE#   ,#P_PROCESS_TYPE# ,#P_PROCESS_CAT#
           ,'BUGSAL_#attributes.sal_mon#_#attributes.sal_year#'            ,'#dateformat(now(),'yyyy-mm-dd')#'            ,#session.ep.userid#
           ,'قيد الراتب الالى لشهر _#attributes.sal_mon#_#attributes.sal_year#'            ,0            ,0            ,0            ,0            ,0
           ,0            ,0            ,0            ,0            ,'YER'            ,0            ,#session.ep.userid#            ,'#dateformat(now(),'dd-mmm-yyyy HH:mm')#'

           ,'192.168.0.96'            ,NULL            ,NULL            ,NULL            ,NULL   ,#session.ep.PERIOD_ID# ,#session.ep.company_id#
           ,NULL            ,NULL            ,NULL            ,NULL)
	                      </cfquery>
	</cfoutput>	
		</cfif>
				 
</td>



      </tr>
      
      <tr>
        	<td colspan="5"><strong>خيارات التصفية</strong></td></tr>
    	<tr>
        	<td style="width:120px"> <input name="new_staff" type="checkbox" id="new_staff" <cfif isdefined('attributes.new_staff') AND LEN(attributes.new_staff)>checked </cfif> />الموظفين الجدد فقط <br />
            <input name="changed_staff" type="checkbox" id="changed_staff"<cfif isdefined('attributes.changed_staff') AND LEN(attributes.changed_staff)>checked </cfif>  />فقط تغيير الموظفين</td>
            <td style="width:120px">رقم الموظف<input type="text" name="Staff_ID" id="Staff_ID" value="<cfif isdefined("attributes.Staff_ID") and len(attributes.Staff_ID)><cfoutput>#attributes.Staff_ID#</cfoutput></cfif>"></td>
             <td style="width:120px">المناصب<input type="text" name="Position" id="Position" value="<cfif isdefined("attributes.Position") and len(attributes.Position)><cfoutput>#attributes.Position#</cfoutput></cfif>"></td>
             
             <td style="width:120px">الأقسام
             <select name="DepartmentXX" id="DepartmentXX" onChange="">
<option value="" selected>الكــل</option>
                    <cfoutput query="getdepartment">
					<option value="#DEPARTMENT_HEAD#" <cfif len(attributes.DepartmentXX) and attributes.DepartmentXX eq DEPARTMENT_HEAD>selected</cfif>>#DEPARTMENT_HEAD#</option>
					</cfoutput>
                </select>
            </td>
            <td style="width:120px">الفئات<select name="FUNC" id="FUNC">
             <option value="" selected>الكــل</option>
                    <cfoutput query="get_FUNC">
					<option value="#UNIT_ID#" <cfif ListFind(attributes.FUNC,UNIT_ID,',')>selected</cfif>>#UNIT_NAME#</option>
					</cfoutput>
                </select></td>
                
                
        </tr>
        <tr>
        <td  colspan="2">المنح<select name="Grant" id="Grant" multiple="multiple" style="width:240px">
                    <cfoutput query="ALLOCATION_">
					<option value="#ALLOCATION_NAME#" <cfif ListFind(attributes.Grant,ALLOCATION_NAME,',')>selected</cfif>>#ALLOCATION_NAME#-#ALLOCATION_NO#</option>
					</cfoutput>
                </select></td>
                <td>الحساب<select name="Accounts" id="Accounts" multiple="multiple" style="width:120px">
                    <cfoutput query="get_FUNC">
					<option value="#UNIT_ID#" <cfif ListFind(attributes.Accounts,UNIT_ID,',')>selected</cfif>>#UNIT_DETAIL#</option>
					</cfoutput>
                    
                </select></td>
        </tr>
        <tr>
        	<td style="width:120px">المراجع 
        	  <input type="hidden" name="REVIEWER1_id" id="REVIEWER1_id" value="<cfif len(attributes.REVIEWER1_id)><cfoutput>#attributes.REVIEWER1_id#</cfoutput></cfif>">
<input type="text" name="REVIEWER1_name" id="REVIEWER1_name" style="width:100px"  onfocus="AutoComplete_Create('REVIEWER1_name','MEMBER_NAME','MEMBER_NAME','get_member_autocomplete','3','EMPLOYEE_ID','REVIEWER1_id','form','3','135')" value="<cfif len(attributes.REVIEWER1_name)><cfoutput>#attributes.REVIEWER1_name#</cfoutput></cfif>" autocomplete="off">
<a href="javascript://" onclick="windowopen('<cfoutput>#request.self#</cfoutput>?fuseaction=objects.popup_list_positions&field_name=form.REVIEWER1_name&field_emp_id=form.REVIEWER1_id<cfif fusebox.circuit is "store">&is_store_module=1</cfif>&select_list=1,9','list');return false"><img src="/images/plus_thin.gif" border="0" align="absmiddle"></a></td>
          <td style="width:120px">موافقة FAD :-
            <input type="hidden" name="APPROVAL1_id" id="APPROVAL1_id" value="<cfif len(attributes.APPROVAL1_id)><cfoutput>#attributes.APPROVAL1_id#</cfoutput></cfif>">
<input type="text" name="APPROVAL1_name" id="APPROVAL1_name" style="width:100px" onfocus="AutoComplete_Create('APPROVAL1_name','MEMBER_NAME','MEMBER_NAME','get_member_autocomplete','3','EMPLOYEE_ID','APPROVAL1_id','form','3','135')" value="<cfif len(attributes.APPROVAL1_name)><cfoutput>#attributes.APPROVAL1_name#</cfoutput></cfif>" autocomplete="off">
<a href="javascript://" onclick="windowopen('<cfoutput>#request.self#</cfoutput>?fuseaction=objects.popup_list_positions&field_name=form.APPROVAL1_name&field_emp_id=form.APPROVAL1_id<cfif fusebox.circuit is "store">&is_store_module=1</cfif>&select_list=1,9','list');return false"><img src="/images/plus_thin.gif" border="0" align="absmiddle"></a>
</td>
          <td style="width:120px">
موافقة CD
  <input type="hidden" name="APPROVAL2_id" id="APPROVAL2_id" value="<cfif len(attributes.APPROVAL2_id)><cfoutput>#attributes.APPROVAL2_id#</cfoutput></cfif>">
<input type="text" name="APPROVAL2_name" id="APPROVAL2_name" style="width:100px" onfocus="AutoComplete_Create('APPROVAL2_name','MEMBER_NAME','MEMBER_NAME','get_member_autocomplete','3','EMPLOYEE_ID','APPROVAL2_id','form','3','135')" value="<cfif len(attributes.APPROVAL2_name)><cfoutput>#attributes.APPROVAL2_name#</cfoutput></cfif>" autocomplete="off">
<a href="javascript://" onclick="windowopen('<cfoutput>#request.self#</cfoutput>?fuseaction=objects.popup_list_positions&field_name=form.APPROVAL2_name&field_emp_id=form.APPROVAL2_id<cfif fusebox.circuit is "store">&is_store_module=1</cfif>&select_list=1,9','list');return false"><img src="/images/plus_thin.gif" border="0" align="absmiddle"></a>
</td>
        </tr>
    </table>    
            
     
        </div>
                <br />

				<select name="distribution" id="distribution" style="width:160px;">
                    <option value="1">بعد التوزيع</option>
                    <option value="2" <cfif len(attributes.distribution) and attributes.distribution eq 2>selected</cfif>>قبل التوزيع</option>
                    
      </select></div>
         <cf_basket_form_button> 
        <cf_wrk_search_button button_type='1' is_excel='0'>
    </cf_basket_form_button>
</cf_basket_form>                     
</cfform>
<div id="list_tb">
<cfif isdefined("attributes.is_form_submitted")>
<cffunction name="getimpdata">
  <cfargument name="type" required="yes">
   <cfargument name="id" required="yes">
    <cfif type eq 1>
    <cfset data=''>
    <cfquery name="GET_FILES" datasource="#dsn#">
   SELECT 
        	EMPLOYEE_ID,
            ASSET_FILE AS ASSET_FILE_NAME
        FROM 
    	   EMPLOYEE_EMPLOYMENT_ROWS,
		   SETUP_EMPLOYMENT_ASSET_CAT
		where 
		SETUP_EMPLOYMENT_ASSET_CAT.ASSET_CAT_ID=EMPLOYEE_EMPLOYMENT_ROWS.ASSET_CAT_ID
		and EMPLOYEE_ID=<cfif NOT LEN(id)>0<cfelse>#id#</cfif>
        and (ASSET_CAT LIKE 'Signature%')
</cfquery>
    <cfelse>
    <cfquery name="GET_FILES" datasource="#dsn#">
   SELECT 
        	EMPLOYEE_ID,
            ASSET_FILE AS ASSET_FILE_NAME
        FROM 
    	   EMPLOYEE_EMPLOYMENT_ROWS,
		   SETUP_EMPLOYMENT_ASSET_CAT
		where 
		SETUP_EMPLOYMENT_ASSET_CAT.ASSET_CAT_ID=EMPLOYEE_EMPLOYMENT_ROWS.ASSET_CAT_ID
		and EMPLOYEE_ID=(select EMPLOYEE_ID from EMPLOYEE_POSITIONS where POSITION_CODE=#id#)
        and (ASSET_CAT LIKE 'Signature%')
</cfquery>
     </cfif>
     <cfif GET_FILES.recordcount>
       <span style="
  mso-ignore:vglayout;
  position: absolute;
  z-index:1;
  margin-left:0px;
  margin-top:0px;
  "><img width="200" src="documents/hr/#GET_FILES.ASSET_FILE_NAME#" v:shapes="Picture_x0020_1"></span>
       <cfelse>
       
     </cfif>
  </cffunction>
 <cfquery name="Get_signs" datasource="#dsn#">
                       SELECT        
                    SAVED_REPORTS.SR_ID, 
                    PAGE_WARNINGS.ACTION_STAGE_ID, 
                    PAGE_WARNINGS.WARNING_HEAD,
                    PAGE_WARNINGS.SETUP_WARNING_ID, 
                     PAGE_WARNINGS.POSITION_CODE, 
                     PAGE_WARNINGS.RECORD_EMP, 
                     PAGE_WARNINGS.RECORD_DATE,
                     PAGE_WARNINGS.WARNING_RESULT,
                     EMAIL_WARNING_DATE,
                     PAGE_WARNINGS.W_ID,
                     (SELECT TOP(1) SV.RECORD_EMP FROM SAVED_REPORTS SV WHERE SV.REPORT_NAME LIKE 'HR_REPORT_#attributes.sal_mon#_#attributes.sal_year#') HR_ID,
                      (SELECT TOP(1) SV.RECORD_DATE FROM SAVED_REPORTS SV WHERE SV.REPORT_NAME LIKE 'HR_REPORT_#attributes.sal_mon#_#attributes.sal_year#') HR_DATE,
                     (SELECT TOP(1) POSITION_NAME FROM EMPLOYEE_POSITIONS WHERE EMPLOYEE_POSITIONS.EMPLOYEE_ID = ISNULL((SELECT TOP(1) SV.RECORD_EMP FROM SAVED_REPORTS SV WHERE SV.REPORT_NAME LIKE 'HR_REPORT_#attributes.sal_mon#_#attributes.sal_year#'),-1)) HR_POSITION_NAME,
                     (SELECT TOP(1) POSITION_NAME FROM EMPLOYEE_POSITIONS WHERE EMPLOYEE_POSITIONS.POSITION_CODE = PAGE_WARNINGS.POSITION_CODE) POSITION_NAME,
                     (SELECT TOP(1) POSITION_NAME FROM EMPLOYEE_POSITIONS WHERE EMPLOYEE_POSITIONS.EMPLOYEE_ID = PAGE_WARNINGS.RECORD_EMP )POSITION_NAME1,
                     CASE WHEN WARNING_RESULT LIKE 'Appr%' then (SELECT TOP(1) WR.RECORD_DATE from PAGE_WARNINGS WR WHERE  WR.PARENT_ID<>WR.W_ID AND PAGE_WARNINGS.PARENT_ID =WR.PARENT_ID) ELSE NULL END AS APPROVE_DATE
FROM            SAVED_REPORTS INNER JOIN
                         PAGE_WARNINGS ON SAVED_REPORTS.SR_ID = PAGE_WARNINGS.ACTION_ID
                         
WHERE         
         PAGE_WARNINGS.SETUP_WARNING_ID in(-2,-3) AND 
         
         (PAGE_WARNINGS.WARNING_HEAD LIKE 'KOA_#attributes.sal_mon#_#attributes.sal_year#' OR PAGE_WARNINGS.WARNING_HEAD LIKE 'Master PAYROLL_#attributes.sal_mon#_#attributes.sal_year#') AND 
        
         (PAGE_WARNINGS.WARNING_PROCESS=1)
         ORDER BY SETUP_WARNING_ID
                    </cfquery>
                    <cfquery name="Get_REVIEW" datasource="#dsn#">
                       SELECT        
                    SAVED_REPORTS.SR_ID, 
                    PAGE_WARNINGS.ACTION_STAGE_ID, 
                    PAGE_WARNINGS.WARNING_HEAD, 
                    PAGE_WARNINGS.SETUP_WARNING_ID, 
                     PAGE_WARNINGS.POSITION_CODE, 
                     PAGE_WARNINGS.RECORD_EMP,
                     PAGE_WARNINGS.RECORD_DATE,
                     EMAIL_WARNING_DATE,
                     PAGE_WARNINGS.WARNING_RESULT,
                     PAGE_WARNINGS.W_ID,
                     (SELECT TOP(1) SV.RECORD_EMP FROM SAVED_REPORTS SV WHERE SV.REPORT_NAME LIKE 'HR_REPORT_#attributes.sal_mon#_#attributes.sal_year#') HR_ID,
                     (SELECT TOP(1) SV.RECORD_DATE FROM SAVED_REPORTS SV WHERE SV.REPORT_NAME LIKE 'HR_REPORT_#attributes.sal_mon#_#attributes.sal_year#') HR_DATE,
                     (SELECT TOP(1) POSITION_NAME FROM EMPLOYEE_POSITIONS WHERE EMPLOYEE_POSITIONS.EMPLOYEE_ID = ISNULL((SELECT TOP(1) SV.RECORD_EMP FROM SAVED_REPORTS SV WHERE SV.REPORT_NAME LIKE 'HR_REPORT_#attributes.sal_mon#_#attributes.sal_year#'),-1)) HR_POSITION_NAME,
                     (SELECT TOP(1) POSITION_NAME FROM EMPLOYEE_POSITIONS WHERE EMPLOYEE_POSITIONS.POSITION_CODE = PAGE_WARNINGS.POSITION_CODE) POSITION_NAME,
                     (SELECT TOP(1) POSITION_NAME FROM EMPLOYEE_POSITIONS WHERE EMPLOYEE_POSITIONS.EMPLOYEE_ID = PAGE_WARNINGS.RECORD_EMP )POSITION_NAME1,
                     CASE WHEN PAGE_WARNINGS.WARNING_RESULT LIKE 'Appr%' then (SELECT TOP(1) WR.RECORD_DATE from PAGE_WARNINGS WR WHERE  WR.PARENT_ID<>WR.W_ID AND PAGE_WARNINGS.PARENT_ID =WR.PARENT_ID) ELSE NULL END AS APPROVE_DATE
FROM            SAVED_REPORTS INNER JOIN
                         PAGE_WARNINGS ON SAVED_REPORTS.SR_ID = PAGE_WARNINGS.ACTION_ID
WHERE     
         (PAGE_WARNINGS.SETUP_WARNING_ID = - 1) AND 
         <cfif len(attributes.Type_id) and attributes.Type_id neq 1>
         (PAGE_WARNINGS.WARNING_HEAD LIKE 'KOA_#attributes.sal_mon#_#attributes.sal_year#' OR PAGE_WARNINGS.WARNING_HEAD LIKE 'Master PAYROLL_#attributes.sal_mon#_#attributes.sal_year#') AND 
         <cfelse>
         (PAGE_WARNINGS.WARNING_HEAD LIKE 'SERVICE_#attributes.sal_mon#_#attributes.sal_year#') AND 
         </cfif>
         (PAGE_WARNINGS.WARNING_PROCESS=1)
                    </cfquery>
<!---<cfif len(attributes.Type_id) and attributes.Type_id eq 5>
<cfquery name="CLOSED_STATE" datasource="#dsn#">
   SELECT * FROM SAVED_REPORTS
   WHERE REPORT_NAME LIKE 'KOA_#attributes.sal_mon#_#attributes.sal_year#'
</cfquery>
</cfif>

<cfif NOT ISDEFINED('CLOSED_STATE') OR (ISDEFINED('CLOSED_STATE') AND NOT CLOSED_STATE.RECORDCOUNT)> --->
<cfset MONTH_DAYS=30>
<cfquery name="GET_MONTH_DAYS" datasource="#DSN#">
 SELECT datediff(day, CONCAT(#attributes.sal_mon#,'/','01', '/',#attributes.sal_year#), dateadd(month, 1, CONCAT(#attributes.sal_mon#,'/','01', '/',#attributes.sal_year#))) AS MONTH_DAYS
</cfquery>
<cfif GET_MONTH_DAYS.recordcount>
<cfif GET_MONTH_DAYS.MONTH_DAYS lte 30>
<cfset MONTH_DAYS=GET_MONTH_DAYS.MONTH_DAYS></cfif></cfif>


<cfquery name="GET_ALLOCATION_PROJECT" datasource="#DSN#">
SELECT DISTINCT ALLOCATION_NO,ALLOCATION_NAME
FROM 
ALLOCATION_PLAN
WHERE
    ALLOCATION_MONTH=#attributes.sal_mon# AND
    ALLOCATION_YEAR=#attributes.sal_year#
    
    
     <cfif len(attributes.Type_id) and attributes.Type_id neq 3 AND LEN(attributes.Grant)>
     AND ( <cfloop from="1" to="#LISTLEN(attributes.Grant)#" index="I">
            ALLOCATION_NAME LIKE '#listgetat(attributes.Grant,I,',')#' 
            <cfif I NEQ LISTLEN(attributes.Grant)>
            OR </cfif>
            </cfloop>)
     </cfif>
order by ALLOCATION_NAME
</cfquery>
<cfscript>
		get_puantaj_ = createObject("component", "v16.hr.ehesap.cfc.get_dynamic_bordro");
		get_puantaj_.dsn = dsn;
		get_puantaj_.dsn_alias = dsn_alias;
		get_puantaj_rows = get_puantaj_.get_dynamic_bordro

		(
			sal_year : attributes.sal_year,
			sal_mon : attributes.sal_mon,
			sal_year_end : attributes.sal_year_end,
			sal_mon_end : attributes.sal_mon_end,
			puantaj_type : -1,
			comp_id : '#session.ep.company_id#',
			branch_id: '#iif(isdefined("attributes.branch_id"),"attributes.branch_id",DE(""))#' ,
	
			department:'#iif(isdefined("attributes.department"),"attributes.department",DE(""))#',
			position_branch_id:'#iif(isdefined("attributes.position_branch_id"),"attributes.position_branch_id",DE(""))#',
			position_department:'#iif(isdefined("attributes.position_department"),"attributes.position_department",DE(""))#',
			is_all_dep:'#iif(isdefined("attributes.is_all_dep"),"attributes.is_all_dep",DE(""))#',
			is_dep_level:'#iif(isdefined("attributes.is_dep_level"),"attributes.is_dep_level",DE(""))#',
			ssk_statute:'#iif(isdefined("attributes.ssk_statute"),"attributes.ssk_statute",DE(""))#',
			duty_type:'#iif(isdefined("attributes.duty_type"),"attributes.duty_type",DE(""))#',
			main_payment_control:'#iif(isdefined("attributes.main_payment_control"),"attributes.main_payment_control",DE(""))#',
			department_level:'#iif(isdefined("attributes.is_dep_level"),"1","0")#',
			expense_center:'#iif(isdefined("attributes.expense_center"),"attributes.expense_center",DE(""))#'
		);
	</cfscript>
    <cfquery name="ddd" datasource="#dsn#">
  SELECT IN_OUT_ID FROM EMPLOYEES_IN_OUT 
   <cfif len(attributes.Type_id) and attributes.Type_id NEQ 1>
  WHERE MONTH(ISNULL(FINISH_DATE,'1990-01-01')) <> CASE WHEN YEAR(ISNULL(FINISH_DATE,'1990-01-01'))=#attributes.sal_year# THEN #attributes.sal_mon# ELSE 0 END
  AND SALARY_TYPE = 2
  <cfif attributes.Type_id EQ 5 AND isdefined('attributes.new_staff') AND LEN(attributes.new_staff)>
   AND  MONTH(START_DATE)=#attributes.sal_mon# AND YEAR(START_DATE)=#attributes.sal_year# 
 </cfif>
  
  <cfelse>
    WHERE SALARY_TYPE = 1
  </cfif>
  <cfif get_puantaj_rows.RECORDCOUNT>
  AND IN_OUT_ID IN (#VALUELIST(get_puantaj_rows.IN_OUT_ID)#)
  <cfelse>
  AND 1=0
  </cfif>
</cfquery>
<cfquery name="getserv" dbtype="query">
   SELECT EMPLOYEE_ID,BRANCH_ID FROM get_puantaj_rows WHERE FUNC_ID=2
</cfquery>
<cfif LEN(attributes.Grant)>
<cfquery name="GET_ALLCTION" datasource="#dsn#">
  SELECT EMP_ID
        FROM 
        ALLOCATION_PLAN
        WHERE
            ALLOCATION_MONTH=#attributes.sal_mon# AND
            ALLOCATION_YEAR=#attributes.sal_year# AND(
            <cfloop from="1" to="#LISTLEN(attributes.Grant)#" index="I">
             <cfif attributes.distribution EQ 2>
             <cfif FIND('YEM Service',listgetat(attributes.Grant,I,','))>
            ( (EMP_ID IN(#VALUELIST(getserv.EMPLOYEE_ID)#)) 
             OR (EMP_ID NOT IN(#VALUELIST(getserv.EMPLOYEE_ID)#) AND ALLOCATION_NAME LIKE '#listgetat(attributes.Grant,I,',')#'  AND RATE<>0))
             <cfelse>
             (EMP_ID NOT IN(#VALUELIST(getserv.EMPLOYEE_ID)#) AND ALLOCATION_NAME LIKE '#listgetat(attributes.Grant,I,',')#'  AND RATE<>0)
             </cfif>
               <cfelse>
               ( ALLOCATION_NAME LIKE '#listgetat(attributes.Grant,I,',')#'  AND RATE<>0)
              </cfif>
            <cfif I NEQ LISTLEN(attributes.Grant)>
            OR </cfif>
            </cfloop>
            )
</cfquery>
</cfif>
<cfquery name="ddd_" dbtype="query">
  select * from get_puantaj_rows  
  WHERE 
  
  IN_OUT_ID IN(<cfif ddd.RECORDCOUNT>#VALUELIST(ddd.IN_OUT_ID)#<cfelse>0</cfif>)
  <cfif len(attributes.Type_id) and attributes.Type_id eq 5>
 <cfif isdefined("attributes.Staff_ID") and len(attributes.Staff_ID)>
 AND EMPLOYEE_NO LIKE '%#attributes.Staff_ID#%'
 </cfif>
  <cfif isdefined("attributes.Position") and len(attributes.Position)>
  AND POSITION_NAME LIKE '%#attributes.Position#%'
  </cfif>
  <cfif isdefined("attributes.DepartmentXX") and len(attributes.DepartmentXX)>
AND DEPARTMENT_HEAD LIKE '#attributes.DepartmentXX#'
</cfif>
<cfif LEN(attributes.Grant)>
   <cfif ISDEFINED('GET_ALLCTION') AND GET_ALLCTION.RECORDCOUNT>
   AND EMPLOYEE_ID IN(#VALUELIST(GET_ALLCTION.EMP_ID)#)
   <cfelse>
   AND 1=0
   </cfif>
</cfif>
<cfif LEN(attributes.Accounts)>
AND FUNC_ID IN (#attributes.Accounts#)
</cfif>
</cfif>
</cfquery>
<cfset get_puantaj_rows=ddd_> 
<cfif len(attributes.Type_id) and attributes.Type_id neq 3 AND NOT LEN(attributes.Grant) AND attributes.distribution NEQ 2>
<cfquery name="GET_ALLOCATION_PROJECT" datasource="#DSN#">
SELECT SUM(RATE),ALLOCATION_NO,ALLOCATION_NAME
FROM 
ALLOCATION_PLAN
WHERE
    ALLOCATION_MONTH=#attributes.sal_mon# AND
    ALLOCATION_YEAR=#attributes.sal_year# AND
    EMP_ID IN (<cfif get_puantaj_rows.RECORDCOUNT>#VALUELIST(get_puantaj_rows.EMPLOYEE_ID)#<cfelse>0</cfif>)
    
     GROUP BY ALLOCATION_NO,ALLOCATION_NAME
     HAVING SUM(RATE) > 0
</cfquery> 
</cfif>
<cfset day_last = createodbcdatetime(createdate(attributes.sal_year_end,attributes.sal_mon_end,daysinmonth(createdate(attributes.sal_year_end,attributes.sal_mon_end,1))))>
<cfset sayfa_no = 0>


<cfscript>
	attributes.startrow = 1;

	t_istisna_odenek = 0;
	t_ssk_matrahi = 0;
	t_gunluk_ucret = 0;
	t_toplam_kazanc = 0;
	t_vergi_indirimi = 0;
	t_sakatlik_indirimi = 0;
	t_kum_gelir_vergisi_matrahi = 0;
	t_gelir_vergisi_matrahi = 0;
	t_gelir_vergisi = 0;
	t_asgari_gecim = 0;
	t_damga_vergisi_matrahi = 0;
	t_damga_vergisi = 0;
	t_mahsup_g_vergisi = 0;	
	t_h_ici = 0;
	t_h_sonu = 0;
	t_toplam_days = 0;
	t_resmi = 0;	
	t_kesinti = 0;
	t_net_ucret = 0;
	t_vergi_iadesi = 0;
	t_ssk_primi_isci = 0;
	t_ssk_primi_isci_devirsiz = 0;
	t_ssk_primi_isveren_hesaplanan = 0;
	t_ssk_primi_isveren = 0;
	t_ssk_primi_isveren_gov = 0;
	t_ssk_primi_isveren_5510 = 0;
	t_ssk_primi_isveren_5084 = 0;
	t_ssk_primi_isveren_5921 = 0;
	t_ssk_primi_isveren_5746 = 0;
	t_ssk_primi_isveren_4691 = 0;
	t_ssk_primi_isveren_6111 = 0;
	t_ssk_primi_isveren_6486 = 0;
	t_ssk_primi_isveren_6322 = 0;
	t_ssk_primi_isci_6322 = 0;
	t_ssk_primi_isveren_14857 = 0;
	
	
	//687 tesvigi
	t_ssk_isveren_hissesi_687 = 0;
	t_ssk_isci_hissesi_687 = 0;
	t_issizlik_isci_hissesi_687 = 0;
	t_issizlik_isveren_hissesi_687 = 0;
	t_gelir_vergisi_indirimi_687 = 0;
	t_damga_vergisi_indirimi_687 = 0;
	
	//7103 tesvigi
	t_ssk_isveren_hissesi_7103 = 0;
	t_ssk_isci_hissesi_7103 = 0;
	t_issizlik_isci_hissesi_7103 = 0;
	t_issizlik_isveren_hissesi_7103 = 0;
	t_gelir_vergisi_indirimi_7103 = 0;
	t_damga_vergisi_indirimi_7103 = 0;
	
	
	t_toplam_isveren = 0;
	t_toplam_isveren_indirimsiz = 0;
	t_issizlik_isci_hissesi = 0;
	t_issizlik_isveren_hissesi = 0;
	t_kidem_isci_payi = 0;
	t_kidem_isveren_payi = 0;
	t_total_pay_ssk_tax = 0;
	t_total_pay_ssk = 0;
	t_total_pay_tax = 0;
	t_total_pay = 0;
	t_onceki_aydan_devreden_kum_mat = 0;
	t_ozel_kesinti = 0;
	t_sgk_normal_gun = 0;
	t_ssk_days = 0;
	t_days = 0;
	sayac = 0;
	ssk_count = 0;
	t_work_days = 0;
	id_list = '';
	t_ssdf_ssk_days = 0;
	t_izin = 0;
	t_izin_paid = 0;
	t_paid_izinli_sunday_count = 0;
	t_sundays = 0;
	t_offdays = 0;
	t_offdays_sundays = 0;
	t_offdays_sundays = 0;
	t_ssdf_sundays = 0;
	t_ssdf_days = 0;
	t_ssdf_izin_days = 0;
	t_ssdf_matrah = 0;
	t_ssdf_isci_hissesi = 0;
	t_ssdf_isveren_hissesi = 0;
	t_aylik_ucret = 0;
	t_aylik = 0;
	t_kanun = 0;
	t_aylik_fazla = 0;
	t_aylik_fazla_mesai_net = 0;
	normal_gun_total = 0;
	haftalik_tatil_total = 0;
	genel_tatil_total = 0;
	izin_total = 0;
	yillik_izin_total = 0;
	mahsup_g_vergisi_ = 0;
	t_maas = 0;
	t_gelir_vergisi_indirimi_5746 = 0;
	t_gelir_vergisi_indirimi_5746_ = 0; //gelir vergisi hesaplanandan dusulmesi icin ayrıldı
	t_gelir_vergisi_indirimi_4691 = 0;
	t_gelir_vergisi_indirimi_4691_ = 0; //gelir vergisi hesaplanandan dusulmesi icin ayrıldı
	t_yillik_izin = 0;
	t_kidem_amount = 0;
	t_ihbar_amount = 0;
	t_vergi_istisna_total = 0;
	t_vergi_istisna_ssk = 0;
	t_vergi_istisna_ssk_net = 0;
	t_vergi_istisna_vergi = 0;
	t_vergi_istisna_vergi_net = 0;
	t_vergi_istisna_damga = 0;
	t_vergi_istisna_damga_net = 0;
	t_devir_fark = 0;
	t_ssk_devir = 0;
	t_ssk_devir_last = 0;
	t_ssk_amount = 0;
	t_onceki_donem_kum_gelir_vergisi_matrahi = 0;
	t_sgk_isci_hissesi_fark = 0;
	t_sgk_issizlik_hissesi_fark = 0;
	t_sgdp_isci_primi_fark = 0;
	gt_hi_saat = 0;
	gt_ht_saat = 0;
	gt_gt_saat = 0;
	gt_paid_izin_saat = 0;
	gt_paid_ht_izin_saat = 0;
	gt_izin_saat = 0;
	gt_toplam_saat = 0;
	gt_gece_mesai_saat = 0;
	dt_izin_saat = 0;
	d_agi_oncesi_net = 0;
	t_agi_oncesi_net = 0;
	t_avans = 0;
	d_t_avans = 0;
	d_t_ssk_matrahi = 0;
	d_t_gunluk_ucret = 0;
	d_t_toplam_kazanc = 0;
	d_t_vergi_indirimi = 0;
	d_t_sakatlik_indirimi = 0;
	d_t_kum_gelir_vergisi_matrahi = 0;
	d_t_gelir_vergisi_matrahi = 0;
	d_t_gelir_vergisi = 0;
	d_t_asgari_gecim = 0;
	d_t_gelir_vergisi=0;
	
	d_t_damga_vergisi_matrahi = 0;
	d_t_damga_vergisi = 0;
	d_t_mahsup_g_vergisi = 0;	
	d_t_h_ici = 0;
	d_t_h_sonu = 0;
	d_t_toplam_days = 0;
	d_t_resmi = 0;	
	d_t_kesinti = 0;
	
	
	

	d_t_net_with=0;
	d_t_diff=0;
	d_t_adv=0;
	
	
	d_t_net_ucret = 0;
	d_t_ssk_primi_isci = 0;
	d_t_bes_isci_hissesi = 0;
	d_t_ssk_primi_isveren_hesaplanan = 0;
	d_t_ssk_primi_isveren = 0;
	d_t_ssk_primi_isveren_gov = 0;
	d_t_ssk_primi_isveren_5510 = 0;
	d_t_ssk_primi_isveren_5084 = 0;
	d_t_ssk_primi_isveren_5921 = 0;
	d_t_ssk_primi_isveren_5746 = 0;
	d_t_ssk_primi_isveren_4691 = 0;
	d_t_ssk_primi_isveren_6111 = 0;
	d_t_ssk_primi_isveren_6486 = 0;
	d_t_ssk_primi_isveren_6322 = 0;
	d_t_ssk_primi_isci_6322 = 0;
	d_t_ssk_primi_isveren_14857 = 0;
	
	
	//687 tesvigi
	d_t_ssk_isveren_hissesi_687 = 0;
	d_t_ssk_isci_hissesi_687 = 0;
	d_t_issizlik_isci_hissesi_687 = 0;
	d_t_issizlik_isveren_hissesi_687 = 0;
	d_t_gelir_vergisi_indirimi_687 = 0;
	d_t_damga_vergisi_indirimi_687 = 0;
	
	//7103 tesvigi
	d_t_ssk_isveren_hissesi_7103 = 0;
	d_t_ssk_isci_hissesi_7103 = 0;
	d_t_issizlik_isci_hissesi_7103 = 0;
	d_t_issizlik_isveren_hissesi_7103 = 0;
	d_t_gelir_vergisi_indirimi_7103 = 0;
	d_t_damga_vergisi_indirimi_7103 = 0;
	
	d_t_toplam_isveren = 0;
	d_t_toplam_isveren_indirimsiz = 0;
	d_t_issizlik_isci_hissesi = 0;
	d_t_issizlik_isveren_hissesi = 0;
	d_t_kidem_isci_payi = 0;
	d_t_kidem_isveren_payi = 0;
	d_t_total_pay_ssk_tax = 0;
	d_t_TOTAL_DAYS = 0;
	d_t_DAMGA_VERGISI_MATRAH =0;
	d_t_DAMGA_VERGISI_MATRAH_days =0;
	d_t_total_pay_ssk = 0;
	d_t_total_pay_tax = 0;
	d_t_total_pay = 0;
	d_t_onceki_aydan_devreden_kum_mat = 0;
	d_t_ozel_kesinti = 0;
	d_t_ssk_days = 0;
	d_t_sgk_normal_gun = 0;
	d_t_days = 0;
	d_sayac = 0;
	d_ssk_count = 0;
	d_t_work_days = 0;
	d_id_list = '';
	d_t_ssdf_ssk_days = 0;
	d_t_izin = 0;
	d_t_izin_paid = 0;
	d_t_paid_izinli_sunday_count = 0;
	d_t_sundays = 0;
	d_t_offdays = 0;
	d_t_offdays_sundays = 0;
	d_t_yillik_izin = 0;
	d_t_offdays_sundays = 0;
	d_t_ssdf_sundays = 0;
	d_t_ssdf_days = 0;
	d_t_ssdf_izin_days = 0;
	d_t_ssdf_matrah = 0;
	d_t_ssdf_isci_hissesi = 0;
	d_t_ssdf_isveren_hissesi = 0;
	d_t_aylik_ucret = 0;
	d_t_aylik = 0;
	d_t_kanun = 0;
	d_t_aylik_fazla = 0;
	d_t_aylik_fazla_mesai_net = 0;
	d_normal_gun_total = 0;
	d_haftalik_tatil_total = 0;
	d_genel_tatil_total = 0;
	d_izin_total = 0;
	d_mahsup_g_vergisi_ = 0;
	d_t_maas = 0;
	d_t_gelir_vergisi_indirimi_5746 = 0;
	d_t_gelir_vergisi_indirimi_5746_ = 0;
	d_t_gelir_vergisi_indirimi_4691 = 0;
	d_t_gelir_vergisi_indirimi_4691_ = 0;
	d_yillik_izin_total = 0;
	d_kidem_amount = 0;
	d_ihbar_amount = 0;
	d_vergi_istisna_total = 0;
	d_vergi_istisna_ssk = 0;
	d_vergi_istisna_ssk_net = 0;
	d_vergi_istisna_vergi = 0;
	d_vergi_istisna_vergi_net = 0;
	d_vergi_istisna_damga = 0;
	d_vergi_istisna_damga_net = 0;
	d_t_devir_fark = 0;
	d_t_ssk_devir = 0;
	d_t_ssk_devir_last = 0;
	d_t_ssk_amount = 0;
	d_net_ucret = 0;
	d_vergi_iadesi = 0;
	d_avans = 0;
	d_ozel_kesinti = 0;
	t_hi_saat = 0;
	t_ht_saat = 0;
	t_gt_saat = 0;
	t_paid_izin_saat = 0;
	t_paid_ht_izin_saat = 0;
	t_izin = 0;

	t_saat = 0;
	t_gece_mesai_saat = 0;
	d_t_onceki_donem_kum_gelir_vergisi_matrahi = 0;
	d_t_sgk_isci_hissesi_fark = 0;
	d_t_sgk_issizlik_hissesi_fark = 0;
	d_t_sgdp_isci_primi_fark = 0;
	t_sgk_isveren_hissesi=0;
	d_t_sgk_isveren_hissesi=0;
	d_t_ssdf_isveren_hissesi=0;
	aylik_brut_ucret = 0;
	t_aylik_brut_ucret = 0;
	t_bes_isci_hissesi=0;
</cfscript>
<cfquery name="GET_EXPENSES" datasource="#iif(fusebox.use_period,"dsn2","dsn")#">
	SELECT 
        EXPENSE, 
        HIERARCHY, 
        EXPENSE_CODE, 
        EXPENSE_ACTIVE 
    FROM 
        EXPENSE_CENTER 
    ORDER BY 
    	EXPENSE_CODE
</cfquery>
<cfset main_expense_list = valuelist(get_expenses.expense_code,';')>
<cfquery name="get_emp_branches" datasource="#DSN#">
	SELECT
		BRANCH_ID
	FROM
		EMPLOYEE_POSITION_BRANCHES
	WHERE
		EMPLOYEE_POSITION_BRANCHES.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.position_code#">
</cfquery>
<cfset emp_branch_list = valuelist(get_emp_branches.branch_id)>
<cfquery name="get_emp_puantaj_ids" datasource="#dsn#">
        SELECT DISTINCT
			EMPLOYEE_PUANTAJ_ID 
		FROM 
			EMPLOYEES_PUANTAJ_ROWS EPR
			INNER JOIN EMPLOYEES_PUANTAJ EP ON EPR.PUANTAJ_ID = EP.PUANTAJ_ID
			INNER JOIN BRANCH B ON EP.SSK_OFFICE = B.SSK_OFFICE AND EP.SSK_OFFICE_NO = B.SSK_NO
		WHERE 
			(
				(EP.SAL_YEAR > <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year#"> AND EP.SAL_YEAR < <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#">)
				OR
				(
					EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year#"> AND 
					EP.SAL_MON >= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon#"> AND
					(
						EP.SAL_YEAR < <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#"> OR
						(EP.SAL_MON <= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon_end#"> AND EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#">)
					)
				)
				OR
				(
					EP.SAL_YEAR > <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year#"> AND 
					(
						EP.SAL_YEAR < <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#"> OR
						(EP.SAL_MON <= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon_end#"> AND EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#">)
					)
				)
				OR
				(
					EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#"> AND 
					EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#"> AND
					EP.SAL_MON >= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon#"> AND
					EP.SAL_MON <= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon_end#">
				)
			) 
			<cfif isdefined("attributes.branch_id") and len(attributes.branch_id)>
				AND B.BRANCH_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#attributes.branch_id#">)	
			</cfif>
            <cfif isdefined("attributes.comp_id") and len(attributes.comp_id)>
				AND B.COMPANY_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#attributes.comp_id#">)	
			</cfif>
			<cfif not session.ep.ehesap>AND B.BRANCH_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#emp_branch_list#">)</cfif>
</cfquery>
<cfset employee_puantaj_ids = valuelist(get_emp_puantaj_ids.employee_puantaj_id)>
<cfquery name="get_kesintis" datasource="#dsn#">
	SELECT 
		PUANTAJ_ID, 
		EMPLOYEE_PUANTAJ_ID, 
		COMMENT_PAY, 
		PAY_METHOD, 
		AMOUNT_2, 
		AMOUNT, 
		SSK, 
		TAX, 
		EXT_TYPE, 
		ACCOUNT_CODE, 
		AMOUNT_PAY
	FROM 
		EMPLOYEES_PUANTAJ_ROWS_EXT
	WHERE 
		<cfif listlen(employee_puantaj_ids)>EMPLOYEE_PUANTAJ_ID IN (#employee_puantaj_ids#)<cfelse>1=0</cfif> AND 
		EXT_TYPE = 1 
	ORDER BY 
		COMMENT_PAY
</cfquery>
<cfquery name="get_kesinti_adlar" dbtype="query">
	SELECT DISTINCT COMMENT_PAY FROM get_kesintis WHERE COMMENT_PAY <> 'Avans' ORDER BY COMMENT_PAY
</cfquery>
<cfset kesinti_names = listsort(valuelist(get_kesinti_adlar.comment_pay),"text","ASC")>
<cfset count_ = 0>
<cfloop list="#kesinti_names#" index="cc">
	<cfset count_ = count_ + 1>
	<cfset 't_kesinti_#count_#' = 0>
	<cfset 'd_t_kesinti_#count_#' = 0>
</cfloop>
<cfquery name="get_odeneks" datasource="#dsn#">
	SELECT 
		EMPLOYEES_PUANTAJ_ROWS_EXT.PUANTAJ_ID, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.EMPLOYEE_PUANTAJ_ID, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.COMMENT_PAY, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.PAY_METHOD, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.AMOUNT_2, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.AMOUNT, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.SSK, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.TAX, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.EXT_TYPE, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.ACCOUNT_CODE, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.AMOUNT_PAY,
		SETUP_PAYMENT_INTERRUPTION.FROM_SALARY,
		SETUP_PAYMENT_INTERRUPTION.CALC_DAYS
	FROM 
		EMPLOYEES_PUANTAJ_ROWS_EXT LEFT JOIN SETUP_PAYMENT_INTERRUPTION
		ON EMPLOYEES_PUANTAJ_ROWS_EXT.COMMENT_PAY_ID = SETUP_PAYMENT_INTERRUPTION.ODKES_ID
	WHERE 
		<cfif listlen(employee_puantaj_ids)>EMPLOYEE_PUANTAJ_ID IN (#employee_puantaj_ids#)<cfelse>1=0</cfif> AND 
		EXT_TYPE = 0 
	ORDER BY 
		COMMENT_PAY
</cfquery>
<cfquery name="get_odenek_adlar" dbtype="query">
	SELECT DISTINCT COMMENT_PAY FROM get_odeneks
</cfquery>
<cfset odenek_names = listsort(valuelist(get_odenek_adlar.comment_pay),"text","ASC")>
<cfset count_ = 0>
<cfloop list="#odenek_names#" index="cc">
	<cfset count_ = count_ + 1>
	<cfset 't_odenek_#count_#' = 0>
	<cfset 'd_t_odenek_#count_#' = 0>
	<cfset 't_odenek_net_#count_#' = 0>
	<cfset 'd_t_odenek_net_#count_#' = 0>
</cfloop>
<cfquery name="get_vergi_istisna" datasource="#dsn#">
	SELECT 
		VERGI_ISTISNA_AMOUNT,
		VERGI_ISTISNA_TOTAL,
		COMMENT_PAY,
		EMPLOYEE_PUANTAJ_ID
	FROM 
		EMPLOYEES_PUANTAJ_ROWS_EXT
	WHERE 
		<cfif listlen(employee_puantaj_ids)>EMPLOYEE_PUANTAJ_ID IN (#employee_puantaj_ids#)<cfelse>1=0</cfif> AND 
		EXT_TYPE = 2 
	ORDER BY 
		COMMENT_PAY
</cfquery>
<cfquery name="get_vergi_istisna_adlar" dbtype="query">
	SELECT DISTINCT COMMENT_PAY FROM get_vergi_istisna
</cfquery>
<cfset vergi_istisna_names = valuelist(get_vergi_istisna_adlar.comment_pay)>
<cfset count_ = 0>
<cfloop list="#vergi_istisna_names#" index="cc">
	<cfset count_ = count_ + 1>
	<cfset 't_vergi_#count_#' = 0>
	<cfset 'd_t_vergi_#count_#' = 0>
	<cfset 't_vergi_net_#count_#' = 0>
	<cfset 'd_t_vergi_net_#count_#' = 0>
</cfloop>
<cfquery name="get_definition" datasource="#DSN#">
	SELECT
		DEFINITION,
		PAYROLL_ID
	FROM
		SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF
    ORDER BY 
    	PAYROLL_ID
</cfquery>
<cfset def_list = listsort(listdeleteduplicates(valuelist(get_definition.payroll_id,',')),'numeric','ASC',',')>

<cfquery name="get_pay_methods" datasource="#dsn#">
	SELECT 
		SP.PAYMETHOD_ID, 
        SP.PAYMETHOD
	FROM 
		SETUP_PAYMETHOD SP,
		SETUP_PAYMETHOD_OUR_COMPANY SPOC
	WHERE
		SP.PAYMETHOD_STATUS = 1
		AND SP.PAYMETHOD_ID = SPOC.PAYMETHOD_ID 
		AND SPOC.OUR_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.company_id#">
</cfquery>
<cfset pay_list = listsort(listdeleteduplicates(valuelist(get_pay_methods.PAYMETHOD_ID,',')),'numeric','ASC',',')>
<cfquery name="get_units" datasource="#DSN#">
	SELECT 
    	UNIT_ID, 
        UNIT_NAME, 
        HIERARCHY 
    FROM 
	    SETUP_CV_UNIT 
    ORDER BY 
    	UNIT_ID
</cfquery>
<cfset fonsiyonel_list = listsort(listdeleteduplicates(valuelist(get_units.unit_id,',')),'numeric','ASC',',')>
<cfquery name="get_position_cats" datasource="#DSN#">
	SELECT 
    	POSITION_CAT_ID, 
        POSITION_CAT,
        HIERARCHY 
    FROM 
    	SETUP_POSITION_CAT 
    ORDER BY 
	    POSITION_CAT_ID
</cfquery>
<cfset position_cat_list = listsort(listdeleteduplicates(valuelist(get_position_cats.POSITION_CAT_ID,',')),'numeric','ASC',',')>
<cfquery name="get_titles" datasource="#DSN#">
	SELECT 
    	TITLE_ID, 
        TITLE 
    FROM 
	    SETUP_TITLE 
    ORDER BY 
    	TITLE_ID
</cfquery>
<cfset title_list = listsort(listdeleteduplicates(valuelist(get_titles.TITLE_ID,',')),'numeric','ASC',',')>
<cfquery name="get_branchs" datasource="#DSN#">
	SELECT BRANCH_ID,BRANCH_NAME FROM BRANCH ORDER BY BRANCH_ID
</cfquery>
<cfset branch_list = listsort(listdeleteduplicates(valuelist(get_branchs.BRANCH_ID,',')),'numeric','ASC',',')>
<cfquery name="get_departments" datasource="#DSN#">
	SELECT DEPARTMENT_ID,DEPARTMENT_HEAD FROM DEPARTMENT ORDER BY DEPARTMENT_ID
</cfquery>
<cfset department_list = listsort(listdeleteduplicates(valuelist(get_departments.DEPARTMENT_ID,',')),'numeric','ASC',',')>
<cfquery name="get_dep_lvl" datasource="#dsn#">
    SELECT DISTINCT LEVEL_NO FROM DEPARTMENT WHERE LEVEL_NO IS NOT NULL ORDER BY LEVEL_NO
</cfquery>
<cfset dep_level_list = listsort(valuelist(get_dep_lvl.level_no),"numeric" ,"ASC")>

<cfset type_ = "employee_puantaj_id">


<cfset sayfa_count_ = 0>
<cfparam name="attributes.totalrecords" default="#get_puantaj_rows.recordcount#">
</cfif>

<cfif isdefined("attributes.is_form_submitted") AND  attributes.Type_id EQ 3>
<cfif GET_ALLOCATION_PROJECT.RECORDCOUNT>
<cfquery name="Get_PROGRAM" dbtype="query">
 	SELECT EMPLOYEE_ID FROM get_puantaj_rows WHERE FUNC_ID = 1
</cfquery>
<cfquery name="Get_SUPPORT" dbtype="query">
 	SELECT EMPLOYEE_ID FROM get_puantaj_rows WHERE FUNC_ID = 1
</cfquery>
<cfquery name="Get_SERVICE" dbtype="query">
 	SELECT EMPLOYEE_ID FROM get_puantaj_rows WHERE FUNC_ID = 2
</cfquery>

<cfoutput query="GET_ALLOCATION_PROJECT">
 <cfset 'T_#CURRENTROW#P_GROSS'=0>
 <cfset 'T_#CURRENTROW#P_9TH'=0>
 <cfset 'T_#CURRENTROW#SP_GROSS'=0>
 <cfset 'T_#CURRENTROW#SP_9TH'=0>
 <cfset 'T_#CURRENTROW#SR_GROSS'=0>
 <cfset 'T_#CURRENTROW#SR_9TH'=0>
 
 <cfset 'T_#CURRENTROW#WO_GROSS'=0>
 <cfset 'T_#CURRENTROW#WO_9TH'=0>
</cfoutput>
 <cfset T_P_ROWG=0>
 <cfset T_P_ROW9=0>
  <cfset T_SP_ROWG=0>
 <cfset T_SP_ROW9=0>
  <cfset T_SR_ROWG=0>
 <cfset T_SR_ROW9=0>
 
  <cfset T_WO_ROWG=0>
 <cfset T_WO_ROW9=0>
 
  <cfset CNT_SP=0>
  <cfset EMP_ERR=''>
<cfoutput query="get_puantaj_rows">
 
    <cfloop query="GET_ALLOCATION_PROJECT">
                          <cfquery name="GET_ALLOCATION_rate" datasource="#DSN#">
                            SELECT 
                            
                             <cfif attributes.distribution EQ 2 and get_puantaj_rows.func_id eq 2>
                            <cfif FIND('YEM Service',ALLOCATION_NAME)>
                            100 AS RATE
                            <cfelse>
                            0 AS RATE
                            </cfif>
                            <cfelse>
                            isnull(RATE,0) RATE 
                            </cfif>
                            FROM ALLOCATION_PLAN 
                            WHERE EMP_ID=#get_puantaj_rows.EMPLOYEE_ID# AND  
                            ALLOCATION_MONTH=#attributes.sal_mon# AND
                            ALLOCATION_YEAR=#attributes.sal_year# AND
                            ALLOCATION_NAME LIKE N'#ALLOCATION_NAME#' AND
                            ALLOCATION_NO LIKE N'#ALLOCATION_NO#'
                          </cfquery>
                          <cfif not GET_ALLOCATION_rate.recordcount or not len(GET_ALLOCATION_rate.RATE)><cfset RATE_=0><cfelse><cfset RATE_=GET_ALLOCATION_rate.RATE></cfif>
                          <cfif isdefined('attributes.Gross_with_adjust') AND LEN(attributes.Gross_with_adjust)>
                    <cfset _gross=(get_puantaj_rows.DAMGA_VERGISI_MATRAH/MONTH_DAYS*get_puantaj_rows.TOTAL_DAYS)+get_puantaj_rows.TOTAL_PAY_SSK_TAX>
                    <cfelse>
                    <cfset _gross=get_puantaj_rows.DAMGA_VERGISI_MATRAH/MONTH_DAYS*get_puantaj_rows.TOTAL_DAYS>
                    </cfif>
                    <cfif LISTFIND(VALUELIST(Get_PROGRAM.EMPLOYEE_ID),get_puantaj_rows.EMPLOYEE_ID)>
                    
		<cfset 'T_#CURRENTROW#P_GROSS'=evaluate('T_#CURRENTROW#P_GROSS')+(_gross*RATE_/100)>
        <cfset 'T_#CURRENTROW#P_9th'=evaluate('T_#CURRENTROW#P_9th')+(get_puantaj_rowsISSIZLIK_ISVEREN_HISSESI*RATE_/100)>
         <cfset T_P_ROWG=T_P_ROWG+(_gross*RATE_/100)>
		 <cfset T_P_ROW9=T_P_ROW9+(get_puantaj_rows.ISSIZLIK_ISVEREN_HISSESI*RATE_/100)>
                  <cfelseif LISTFIND(VALUELIST(Get_SUPPORT.EMPLOYEE_ID),get_puantaj_rows.EMPLOYEE_ID)>
                   <cfset CNT_SP=CNT_SP+1>
        <cfset 'T_#CURRENTROW#SP_GROSS'=evaluate('T_#CURRENTROW#SP_GROSS')+(_gross*RATE_/100)>
        <cfset 'T_#CURRENTROW#SP_9th'=evaluate('T_#CURRENTROW#SP_9TH')+(get_puantaj_rows.ISSIZLIK_ISVEREN_HISSESI*RATE_/100)>
        <cfset T_SP_ROWG=T_SP_ROWG+(_gross*RATE_/100)>
		 <cfset T_SP_ROW9=T_SP_ROW9+(get_puantaj_rows.ISSIZLIK_ISVEREN_HISSESI*RATE_/100)>
                    <cfelseif LISTFIND(VALUELIST(Get_SERVICE.EMPLOYEE_ID),get_puantaj_rows.EMPLOYEE_ID)>
        <cfset 'T_#CURRENTROW#SR_GROSS'=evaluate('T_#CURRENTROW#SR_GROSS')+(_gross*RATE_/100)>
        <cfset 'T_#CURRENTROW#SR_9th'=evaluate('T_#CURRENTROW#SR_9TH')+(get_puantaj_rows.ISSIZLIK_ISVEREN_HISSESI*RATE_/100)>  
        <cfset T_SR_ROWG=T_SR_ROWG+(_gross*RATE_/100)>
		 <cfset T_SR_ROW9=T_SR_ROW9+(get_puantaj_rows.ISSIZLIK_ISVEREN_HISSESI*RATE_/100)> 
         <cfelse>
          <!--- <cfset EMP_ERR=EMP_ERR&get_puantaj_rows.EMPLOYEE_ID&','>--->
            <cfset 'T_#CURRENTROW#WO_GROSS'=evaluate('T_#CURRENTROW#WO_GROSS')+(_gross*RATE_/100)>
        <cfset 'T_#CURRENTROW#WO_9th'=evaluate('T_#CURRENTROW#WO_9TH')+(get_puantaj_rows.ISSIZLIK_ISVEREN_HISSESI*RATE_/100)>  
        <cfset T_WO_ROWG=T_WO_ROWG+(_gross*RATE_/100)>
		 <cfset T_WO_ROW9=T_WO_ROW9+(get_puantaj_rows.ISSIZLIK_ISVEREN_HISSESI*RATE_/100)> 
                    </cfif>
                         </cfloop>
  </cfoutput>
<cfquery name="GET_AGG_P_T" dbtype="query">
    SELECT SUM(ISSIZLIK_ISVEREN_HISSESI) AS 9TH,COUNT(EMPLOYEE_ID) No_of_staff,SUM(DAMGA_VERGISI_MATRAH*(TOTAL_DAYS/#MONTH_DAYS#) <cfif isdefined('attributes.Gross_with_adjust') AND LEN(attributes.Gross_with_adjust)>+TOTAL_PAY_SSK_TAX</cfif>) AS GROS FROM get_puantaj_rows
    WHERE EMPLOYEE_ID IN (#VALUELIST(Get_PROGRAM.EMPLOYEE_ID)#)
</cfquery>
<cfquery name="GET_AGG_SP_T" dbtype="query">
    SELECT SUM(ISSIZLIK_ISVEREN_HISSESI) AS 9TH,COUNT(EMPLOYEE_ID) No_of_staff,SUM(DAMGA_VERGISI_MATRAH*(TOTAL_DAYS/#MONTH_DAYS#) <cfif isdefined('attributes.Gross_with_adjust') AND LEN(attributes.Gross_with_adjust)>+TOTAL_PAY_SSK_TAX</cfif>) AS GROS,COUNT(EMPLOYEE_ID) CNT FROM get_puantaj_rows
    WHERE EMPLOYEE_ID IN (#VALUELIST(Get_SUPPORT.EMPLOYEE_ID)#)
</cfquery>
<cfquery name="GET_AGG_SR_T" dbtype="query">
    SELECT SUM(ISSIZLIK_ISVEREN_HISSESI) AS 9TH,COUNT(EMPLOYEE_ID) No_of_staff,SUM(DAMGA_VERGISI_MATRAH*(TOTAL_DAYS/#MONTH_DAYS#) <cfif isdefined('attributes.Gross_with_adjust') AND LEN(attributes.Gross_with_adjust)>+TOTAL_PAY_SSK_TAX</cfif>) AS GROS FROM get_puantaj_rows
    WHERE EMPLOYEE_ID >1
</cfquery>
<cfquery name="GET_AGG_WO_T" dbtype="query">
    SELECT SUM(ISSIZLIK_ISVEREN_HISSESI) AS 9TH,COUNT(EMPLOYEE_ID) No_of_staff,SUM(DAMGA_VERGISI_MATRAH*(TOTAL_DAYS/#MONTH_DAYS#) <cfif isdefined('attributes.Gross_with_adjust') AND LEN(attributes.Gross_with_adjust)>+TOTAL_PAY_SSK_TAX</cfif>) AS GROS FROM get_puantaj_rows
    WHERE EMPLOYEE_ID >1
    AND EMPLOYEE_ID >1
    AND EMPLOYEE_ID >1
</cfquery>

<cfset c_no=1>
   <cfif GET_ALLOCATION_PROJECT.recordcount>
   <cfset c_no=GET_ALLOCATION_PROJECT.recordcount+1>
   </cfif>
<table class="basket_list" id="list_tb" width="99%" align="Right" dir="rtl">
<cfset row_color="border:1px solid ##000;">
<tr>
   <th rowspan="2" style="border:1px solid #000;">#</th>
   <th  style="border:1px solid #000;"></th>
   <th rowspan="2" style="border:1px solid #000;">فئات</th>
   <th rowspan="2" style="border:1px solid #000;">انواع</th>
   <th rowspan="2" style="border:1px solid #000; text-align:center; width:50px">الحساب</th>
   <th rowspan="2" style="border:1px solid #000; text-align:center; width:50px">عدد الموظفين</th>
    <th colspan="<cfoutput>#c_no#</cfoutput>" style="border:1px solid #000; text-align:center">ALLOCATIONS</th>
    <th rowspan="2" style="border:1px solid #000; text-align:center">STATE</th>
   </tr>
   <tr>
   <cfoutput query="GET_ALLOCATION_PROJECT">
   <th style="border:1px solid ##000; text-align:center">#ALLOCATION_NAME#<cfif FIND('YEM Service',ALLOCATION_NAME)><BR />#ALLOCATION_NO#</cfif></th>
   </cfoutput>
    <th style="border:1px solid #000;"> TOTAL</th>
   </tr>
   <tr style="background-color:rgb(237,254,254)">
   <td rowspan="2"  style="border:1px solid #000;">1</td>
   <td rowspan="2"  style="border:1px solid #000;">PROGRAM</td>
   <td style="border:1px solid #000; text-align:center;background-color:rgb(203,222,254)">GROSS</td>
   <td style="border:1px solid #000;text-align:center;background-color:rgb(203,222,254)">50-30-102</td>
   <td rowspan="2" style="border:1px solid #000;text-align:center"><cfoutput>#GET_AGG_P_T.No_of_staff#</cfoutput></td>
   <cfoutput query="GET_ALLOCATION_PROJECT">
    <td style="border:1px solid ##000; text-align:center;background-color:rgb(203,222,254)">#tlformat(evaluate('T_#CURRENTROW#P_GROSS'))#</td>
   </cfoutput>
    <td style="border:1px solid #000;;background-color:rgb(203,222,254)"> <cfoutput>#tlformat(T_P_ROWG)#</cfoutput></td>
     <cfif GET_AGG_P_T.recordcount and tlformat(GET_AGG_P_T.GROS) NEQ tlformat(T_P_ROWG)>
     <td rowspan="2" style="background:#F00; text-align:center">يجب أن يكون الإجمالي الإجمالي <cfoutput>#tlformat(GET_AGG_P_T.GROS)#</cfoutput></td>
    <cfelse>
    <td rowspan="2" style="border:1px solid #000;"></td>
    </cfif>
   </tr>
    <tr>
   <td style="border:1px solid #000;text-align:center">S.S 12%</td>
   <td style="border:1px solid #000;text-align:center">50-30-110</td>
   <cfoutput query="GET_ALLOCATION_PROJECT">
    <td style="border:1px solid ##000; text-align:center">#tlformat(evaluate('T_#CURRENTROW#P_9TH'))#</td>
   </cfoutput>
    <td  style="border:1px solid #000;text-align:center"> <cfoutput>#tlformat(T_P_ROW9)#</cfoutput></td>
   </tr>
   
   
    <tr>
   <td rowspan="2" style="border:1px solid #000;">2</td>
   <td rowspan="2" style="border:1px solid #000;">SUPPORT</td>
  
   <td style="border:1px solid #000;background-color:rgb(203,222,254)">GROSS</td>
   <td style="border:1px solid #000;text-align:center;background-color:rgb(203,222,254)">50-30-101</td>
   <td rowspan="2" style="border:1px solid #000;text-align:center"><cfoutput>#GET_AGG_SP_T.No_of_staff#</cfoutput></td>
   <cfoutput query="GET_ALLOCATION_PROJECT">
    <td style="border:1px solid ##000; text-align:center;background-color:rgb(203,222,254)">#tlformat(evaluate('T_#CURRENTROW#SP_GROSS'))#</td>
   </cfoutput>
    <td style="border:1px solid #000;background-color:rgb(203,222,254)"> <cfoutput>#tlformat(T_SP_ROWG)#</cfoutput></td>
    <cfif GET_AGG_SP_T.recordcount and tlformat(GET_AGG_SP_T.GROS) NEQ tlformat(T_SP_ROWG)>
     <td rowspan="2" style="background:#F00; text-align:center;border:1px solid #000;" rowspan="2"><span style="background:#F00; text-align:center">Gross Total must be <cfoutput>#tlformat(GET_AGG_SP_T.GROS)#</cfoutput> </span></td>
    <cfelse>
    <td rowspan="2" style="border:1px solid #000;"></td>
    </cfif>
   </tr>
   <tr>
   <td style="border:1px solid #000;text-align:center">S.S 12%</td>
   <td style="border:1px solid #000;text-align:center">50-30-110</td>
   <cfoutput query="GET_ALLOCATION_PROJECT">
    <td style="border:1px solid ##000; text-align:center">#tlformat(evaluate('T_#CURRENTROW#SP_9TH'))#</td>
   </cfoutput>
    <td  style="border:1px solid #000;text-align:center"> <cfoutput>#tlformat(T_SP_ROW9)#</cfoutput></td>
   </tr>
   
   <tr>
   <td rowspan="3" style="border:1px solid #000;">3</td>
   <td rowspan="3"  style="border:1px solid #000;">SERVICE</td>
  
   <td style="border:1px solid #000;background-color:rgb(203,222,254)">GROSS</td>
   <td style="border:1px solid #000;text-align:center;background-color:rgb(203,222,254)">50-30-103</td>
   <td rowspan="3" style="border:1px solid #000;text-align:center"><cfoutput>#GET_AGG_SR_T.No_of_staff#</cfoutput></td>
   <cfoutput query="GET_ALLOCATION_PROJECT">
    <td style="border:1px solid ##000; text-align:center;background-color:rgb(203,222,254)">#tlformat(evaluate('T_#CURRENTROW#SR_GROSS'))#</td>
   </cfoutput>
    <td  style="border:1px solid #000;background-color:rgb(203,222,254)"> <cfoutput>#tlformat(T_SR_ROWG)#</cfoutput></td>
    <cfif GET_AGG_SR_T.recordcount and tlformat(GET_AGG_SR_T.GROS) NEQ tlformat(T_SR_ROWG)>
     <td  rowspan="3"  style="background:#F00;text-align:center;border:1px solid #000;" rowspan="2"> Total must be <cfoutput>#tlformat(GET_AGG_SR_T.GROS)#</cfoutput></td>
    <cfelse>
    <td  rowspan="3"  style="border:1px solid #000;"></td>
    </cfif>
   </tr>
   <tr>
   <td style="border:1px solid #000;text-align:center">S.S 12%</td>
   <td style="border:1px solid #000;text-align:center">50-30-110</td>
   <cfoutput query="GET_ALLOCATION_PROJECT">
    <td style="border:1px solid ##000; text-align:center">#tlformat(evaluate('T_#CURRENTROW#SR_9TH'))#</td>
   </cfoutput>
    <td  style="border:1px solid #000;text-align:center"> <cfoutput>#tlformat(T_SR_ROW9)#</cfoutput></td>
   </tr>
   <tr>
   <td colspan="2" style="border:1px solid #000;text-align:center">Allocation %</td>
   <cfset PERCENT=0>
   <cfoutput query="GET_ALLOCATION_PROJECT">
    <td style="border:1px solid ##000; text-align:center">#tlformat(evaluate('T_#CURRENTROW#SR_GROSS')/GET_AGG_SR_T.GROS*100)#%</td>
    <cfset PERCENT=PERCENT+evaluate('T_#CURRENTROW#SR_GROSS')/GET_AGG_SR_T.GROS*100>
   </cfoutput>
    <td  style="border:1px solid #000;text-align:center"> <cfoutput>#tlformat(PERCENT)#</cfoutput>%</td>
   </tr>
   <cfset nounknownstaff=0>
   <cfif T_WO_ROWG GT 0>
   <cfset nounknownstaff=GET_AGG_WO_T.No_of_staff>
    <tr>
   <td style="border:1px solid #000;">4</td>
   <td style="border:1px solid #000;" >STAFF W/O CATEGORY</td>
   <td style="border:1px solid #000;">GROSS</td>
   <td></td>
   <td  style="border:1px solid #000;text-align:center"><cfoutput>#GET_AGG_WO_T.No_of_staff#</cfoutput></td>
   <cfoutput query="GET_ALLOCATION_PROJECT">
    <td style="border:1px solid ##000; text-align:center">#tlformat(evaluate('T_#CURRENTROW#WO_GROSS'))#</td>
   </cfoutput>
    <td> <cfoutput>#tlformat(T_WO_ROWG)#</cfoutput></td>
     <td style="background:#F00; text-align:center"> لا يفترض أن يتم العثور عليها</td>
   
   </tr>
   
   </cfif>

   <tr>
   <td style="border:1px solid #006;" colspan="3">الاجمالي S.S 15%</td>
   <td style="border:1px solid #000;text-align:center">50-30-110</td>
   <td style="border:1px solid #000;text-align:center"><cfoutput>#listlen(valuelist(get_puantaj_rows.EMPLOYEE_ID))#</cfoutput></td>
   <cfoutput query="GET_ALLOCATION_PROJECT">
    <td style="border:1px solid ##006; text-align:center">#tlformat(evaluate('T_#CURRENTROW#P_9TH')+evaluate('T_#CURRENTROW#SP_9TH')+evaluate('T_#CURRENTROW#SR_9TH')+evaluate('T_#CURRENTROW#WO_9TH'))#</td>
   </cfoutput>
   <td style="border:1px solid #006; text-align:center"><cfoutput>#tlformat(T_P_ROW9+T_SP_ROW9+T_SR_ROW9+T_WO_ROW9)#</cfoutput></td>
    <td style="border:1px solid #006;"></td>
   </tr><cfoutput>
                    <cfif Get_signs.RECORDCOUNT OR Get_REVIEW.RECORDCOUNT>
                    <cfset REC_EMP=-1>
					<cfSET REC_POS='Finance Manager'>
                    <cfset REC_DATE=''>
                    <cfset HR_REC_EMP=-1>
                    <cfSET HR_REC_POS='HR & Admin Manager'>
                    <cfset HR_REC_DATE=''>
                    <cfif Get_signs.RECORDCOUNT>
                    <cfSET REC_POS=Get_signs.POSITION_NAME1>
                    <cfSET HR_REC_POS=Get_signs.HR_POSITION_NAME>
					<cfset REC_EMP=Get_signs.RECORD_EMP>
                    
                    <cfif NOT FIND('Finance',Get_signs.POSITION_NAME1) OR NOT FIND('Manager',Get_signs.POSITION_NAME1)>
					<cfSET REC_POS='Acting Finance Manager'>
                    </cfif>
                     <cfset REC_DATE=Get_signs.RECORD_DATE>
                    <cfset HR_REC_EMP=Get_signs.HR_ID>
                    
                    <cfif NOT FIND('HR',Get_signs.HR_POSITION_NAME) OR NOT FIND('Manager',Get_signs.HR_POSITION_NAME)>
					<cfSET HR_REC_POS='Acting HR & Admin Manager'>
                    </cfif>
                    
                    <cfset HR_REC_DATE=Get_signs.HR_DATE>
                    <cfelse>
                    <cfSET REC_POS=Get_REVIEW.POSITION_NAME1>
                    <cfSET HR_REC_POS=Get_REVIEW.HR_POSITION_NAME>
                    <cfset REC_EMP=Get_REVIEW.RECORD_EMP>
                    <cfif NOT FIND('Finance',Get_REVIEW.POSITION_NAME1) OR NOT FIND('Manager',Get_REVIEW.POSITION_NAME1)>
					<cfSET REC_POS='Acting Finance Manager'>
                    </cfif>
                     <cfset REC_DATE=Get_REVIEW.RECORD_DATE>
                    <cfset HR_REC_EMP=Get_REVIEW.HR_ID>
                    <cfif NOT FIND('HR',Get_REVIEW.HR_POSITION_NAME) OR NOT FIND('Manager',Get_REVIEW.HR_POSITION_NAME)>
					<cfSET HR_REC_POS='Acting HR & Admin Manager'>
                    </cfif>
                    <cfset HR_REC_DATE=Get_REVIEW.HR_DATE>
                    </cfif>
                    <tr id="sign">
                    <td colspan="#GET_ALLOCATION_PROJECT.recordcount+2+5#">
                    <table style="width:100%" align="Right" dir="rtl">
                    <tr>
                    <cfset column_total='text-align:center; font-size:12px; width:15%'>
                     <td style="#column_total#"><cfscript>getimpdata(1,REC_EMP);</cfscript>
                       تمت مراجعته من قبل<BR />#get_emp_info(REC_EMP,0,0)#<BR  />#REC_POS#<br /><br />#dateformat(REC_DATE, 'dd-mmm-yyyy ')##TimeFormat(REC_DATE,"HH:mm")#
                      </td>
                      <td style="#column_total#"><cfscript>getimpdata(1,HR_REC_EMP);</cfscript>
                        أعدت بواسطة<BR />#get_emp_info(HR_REC_EMP,0,0)#<BR  />#HR_REC_POS#<br /><br />#dateformat(HR_REC_DATE, 'dd-mmm-yyyy ')##TimeFormat(HR_REC_DATE,"HH:mm")#
                      </td>
                     
                       <cfif not len(Get_REVIEW.WARNING_RESULT)>
                        <td style="#column_total#">
                        <font color="RED"> لم تتم المراجعة حتى الآن<br />#get_emp_info(Get_REVIEW.POSITION_CODE,1,0)#<br /><cfif NOT FIND('Compliance',Get_REVIEW.POSITION_NAME) OR NOT FIND('Manager',Get_REVIEW.POSITION_NAME)>القائم بأعمال مدير الامتثال<cfelse>#Get_REVIEW.POSITION_NAME#</cfif></font></td>
                        <cfelseif find('Rejec',Get_REVIEW.WARNING_RESULT)>
                        <td style="#column_total#">
                        <font color="RED"> مرفوض من طرف<br />#get_emp_info(Get_REVIEW.POSITION_CODE,1,0)#<br /><cfif NOT FIND('Compliance',Get_REVIEW.POSITION_NAME) OR NOT FIND('Manager',Get_REVIEW.POSITION_NAME)>
                         العمل بالامتثال Manager<cfelse>#Get_REVIEW.POSITION_NAME#</cfif></font></td>
                        <cfelseif find('Appro',Get_REVIEW.WARNING_RESULT)>
                        <td style="text-align:center; font-size:12px">
						<cfscript>getimpdata(2,Get_REVIEW.POSITION_CODE);</cfscript>
                        أكد عن طريق<br />#get_emp_info(Get_REVIEW.POSITION_CODE,1,0)#<br /><cfif NOT FIND('Compliance',Get_REVIEW.POSITION_NAME) OR NOT FIND('Manager',Get_REVIEW.POSITION_NAME)>
                          العمل بالامتثال Manager<cfelse>#Get_REVIEW.POSITION_NAME#</cfif><br /><br />#dateformat(Get_REVIEW.APPROVE_DATE, 'dd-mmm-yyyy ')##TimeFormat(Get_REVIEW.APPROVE_DATE,"HH:mm")#</td>
                      </cfif>
                       <td style="text-align:center; font-size:12px; width:25%"></td>
                       
                       <cfloop query="Get_signs">
                        <cfset sign_possition=Get_signs.POSITION_NAME>
                       
                      <cfif currentrow eq 1>
                       
                       <cfif NOT FIND('Finance',Get_signs.POSITION_NAME) OR NOT FIND('Director',Get_signs.POSITION_NAME)>
                       <cfset sign_possition='Acting Finance Administrative Director'>
                       </cfif>
                       <cfelse>
                       <cfif NOT FIND('Country',Get_signs.POSITION_NAME) OR NOT FIND('Director',Get_signs.POSITION_NAME)>
                       <cfset sign_possition='Acting Country Director'>
                       </cfif>
                       
                       </cfif>
                       
                        <cfif not len(Get_signs.WARNING_RESULT)>
                        <td style="#column_total#">
                        <font color="RED"> لم تتم الموافقة عليها بعد<br />#get_emp_info(Get_signs.POSITION_CODE,1,0)#<br />#sign_possition#</font></td>
                        <cfelseif find('Rejec',Get_signs.WARNING_RESULT)>
                        <td style="#column_total#">
                        <font color="RED"> مرفوض من طرف<br />#get_emp_info(Get_signs.POSITION_CODE,1,0)#<br />#sign_possition#</font></td>
                        <cfelseif find('Appro',Get_signs.WARNING_RESULT)>
                        <td style="#column_total#"><cfscript>getimpdata(2,Get_signs.POSITION_CODE);</cfscript>
                        تمت الموافقة عليه من قبل<br />#get_emp_info(Get_signs.POSITION_CODE,1,0)#<br />#sign_possition#<br /><br />#dateformat(Get_signs.APPROVE_DATE, 'dd-mmm-yyyy ')##TimeFormat(Get_signs.APPROVE_DATE,"HH:mm")#</td>
                        </cfif>
                      </cfloop>
                    </tr>
                    </table>
                    </td>
                    </tr>
                    </cfif>  </cfoutput>                
   <cfquery name="find_closed_state" datasource="#DSN#">
      SELECT * FROM SAVED_REPORTS
      WHERE REPORT_NAME LIKE 'FINAL_KOA_#attributes.sal_mon#_#attributes.sal_year#' 
      <!---<cfif attributes.sal_mon neq 12>
      <cfloop from="#attributes.sal_mon+1#" to="12" index="i">
      OR REPORT_NAME LIKE 'FINAL_KOA_#i#_#attributes.sal_year#'  
      </cfloop>
      </cfif>--->
   </cfquery>
   
   <cfoutput>
   
   <cfif not find_closed_state.recordcount and len(attributes.branch_id)>
   <tr>
     <td colspan="#7+GET_ALLOCATION_PROJECT.recordcount#" style="text-align:RIGHT">من أجل توزيع النسب المئوية LOA  الجديدة لموظفي الخدمة ، يرجى النقر <strong><a href="javascript://" onclick="windowopen('#request.self#?fuseaction=report.detail_report&report_id=#attributes.report_id#&reger_service&sal_mon=#attributes.sal_mon#&sal_year=#attributes.sal_year#&BRANCH_ID=#attributes.branch_id#&Get_PROGRAM=#valuelist(Get_PROGRAM.EMPLOYEE_ID)#&Get_SERVICE=#valuelist(Get_SERVICE.EMPLOYEE_ID)#','small');">HERE</a></strong></td></tr>
   <cfelseif find_closed_state.recordcount>
    
   <cfelse>
   <tr>
   <td colspan="#6+GET_ALLOCATION_PROJECT.recordcount#" style="text-align:RIGHT">
   <strong>يرجى تحديد اسم الفرع لتوزيع نسب LOA الجديدة من موظفي الخدمة</strong></td> 
   </tr>
   </cfif>
  
   </cfoutput>

  
</table>
<cfelse>
<span style="border:1px solid #000; text-align:center">ALLOCATIONS</span>لم يتم العثور على بيانات
</cfif>
<cfelseif isdefined("attributes.is_form_submitted")>

<cfif len(attributes.FUNC)>
  <cfquery name="GET_AGG_puantaj_rows" dbtype="query">
    SELECT * FROM get_puantaj_rows
    WHERE FUNC_ID = #attributes.FUNC#
</cfquery>
<cfset get_puantaj_rows =GET_AGG_puantaj_rows>
</cfif>
<cfquery name="check" datasource="#dsn#">
	SELECT
		COMPANY_NAME,
		TEL_CODE,
		TEL,
		TEL2,
		TEL3,
		TEL4,
		FAX,
		ADDRESS,
		WEB,
		EMAIL,
		ASSET_FILE_NAME3,
		ASSET_FILE_NAME3_SERVER_ID,
		TAX_OFFICE,
		TAX_NO
	FROM
		OUR_COMPANY
	WHERE
		<cfif isDefined("session.ep.company_id")>
			COMP_ID = #session.ep.company_id#
		<cfelseif isDefined("session.pp.company")>	
			COMP_ID = #session.pp.company_id#
		</cfif> 
</cfquery>
  <cfset c_no=1>
   <cfif GET_ALLOCATION_PROJECT.recordcount>
   <cfset c_no=GET_ALLOCATION_PROJECT.recordcount+1>
   </cfif>
   <cfset col_no=9>
	<cfif  attributes.Type_id eq 4>
    <cfset col_no=7+c_no>
    </cfif>
<table class="basket_list" width="99%"   id="list_tb" style="border:hidden;"align="Right" dir="rtl">
 <cfoutput>
        <tr class="txtbold" align="left" style="border:hidden;">
				<td colspan="5" rowspan="2" style="text-align:center;background:##FFF"><cfif len(check.asset_file_name3)><cf_get_server_file output_file="settings/#check.asset_file_name3#" output_server="#check.asset_file_name3_server_id#" output_type="5"></cfif></td>
		<td  colspan="8" style=" font-family:'Times New Roman', Times, serif; font-size:24px"><cfif len(attributes.branch_id)><cfloop query="get_branch"><cfif branch_id eq attributes.branch_id>#Replace(get_branch.branch_name,'/','&')#</cfif></cfloop><cfelse>#Replace(Replace(Valuelist(get_branch.branch_name),'/','&'),',',', ','all')#</cfif>		   - الجمهورية اليمنية</td>
        </tr>
        <tr style="border:hidden;">
  <td  colspan="9" style=" font-family:'Times New Roman', Times, serif; font-size:24px">كشوف المرتبات لشهر #DateFormat('20/#attributes.sal_mon#/#attributes.sal_year#','MMMM, yy')#  <cfif len(attributes.Type_id) and attributes.Type_id eq 1><br /></cfif>
    <cfif len(attributes.Type_id) and attributes.Type_id eq 1>
      عقد موظفي الخدمة
    </cfif></td>
 </tr>
 
   <tr style="border:hidden;">
  <td style="background:##EBE600;  border:1px solid ##000; width:3px"></td>
  <td colspan="4">طاقم جديد</td></tr>
  <tr style="border:hidden;">
  <td style="background:##FFC000;  border:1px solid ##000;"></td>
  <td colspan="4"> تغيير الموظفين</td>
   <cfif ListFind(attributes.Grant_option,1,',')>
  <tr style="border:hidden;">
   <td style="background:##95B3D7;  border:1px solid ##000;">%</td>
  <td colspan="4">Allocation نسبة </td>
  </tr>
  </cfif>
   <cfif ListFind(attributes.Grant_option,2,',')>
   <tr>
   <td style="background:##DA9694;  border:1px solid ##000;">S</td>
  <td colspan="4"> رواتب Allcoation</td>
  </tr>
  </cfif>
   <cfif ListFind(attributes.Grant_option,3,',')>
   <tr style="border:hidden;">
   <td style="background:##D9D9D9;  border:1px solid ##000;">S.S</td>
  <td colspan="4">اجتماعي Allocation</td>
  </tr>
  </cfif>
        
       </cfoutput>
</table>
<table class="basket_list" id="list_tb"  width="99%" align="Right" dir="rtl">
<cfif isdefined("attributes.is_form_submitted")>
<cfset total_taxable=0>
    <cfset sayfa_count_ = sayfa_count_ + 1>
    <cfif (sayfa_count_ eq 1)>
        <cfset sayfa_no = sayfa_no + 1>
        <cfset cols_plus = 0>
        </cfif>
 <cfset Total_adjustment=0>

        <thead>
       
            <tr class="txtbold" align="left">	
             <th style="border:1px solid #000;">#</th>                 
																																													 
   <th  style="border:1px solid #000;">رقم الموظف#</th>
 <!---  <th style="border:1px solid #000;">الفئات</th>
   <th style="border:1px solid #000;width:50px;">الحسابات</th>--->
   <th style="border:1px solid #000;">اسم الموظف</th>
	  
		
 
 
							 
										   
   <!---<th style="border:1px solid #000;">الاقسام</th>
																																																  
   <th style="border:1px solid #000;">المسمى الوظيفي</th>
   <th style="border:1px solid #000;width:10;">الفرع</th>  --->    
    <cfif not len(attributes.col_option)> 
   <!--- <th style="border:1px solid #000;">الحساب البنكي</th>--->
   <th style="border:1px solid #000;width:10;"> عدد أيام العمل</th>
																																															   
																																																	
   <th style="border:1px solid #000;">الراتب الاساسي</th>
     <th style="border:1px solid #000;">بدل موصلات</th>
   <th style="border:1px solid #000;">بدل تمثيل </th> 
   <th style="border:1px solid #000;">بدل مظهر </th> 
    <th style="border:1px solid #000;"> بدل طبيعة عمل </th>
   <!--- أجمالي البدلات--->
   <th style="border:1px solid #000;">الراتب الاجمالي</th>																																																					  
   </cfif>
   <cfif ListFind(attributes.col_option,1,',') OR not len(attributes.col_option)>  
      <th style="border:1px solid #000;"> حصــة الشركة بتأمين الاجتماعي</th>
   </cfif>
   <th style="border:1px solid #000;">حصــة التدريب</th>
     <th style="border:1px solid #000;">صنــدوق التكافل قسط شركة</th>
   <cfif ListFind(attributes.col_option,2,',')OR not len(attributes.col_option)>
   <th style="border:1px solid #000;"> حصــة الموظف بتأمين الاجتماعي</th>
   </cfif>
   <cfif not len(attributes.col_option)> 
   
    
    	 <th style="border:1px solid #000;width:10;"> دقائق التأخير</th>																																																							
	<th style="border:1px solid #000;width:10;">المغادرات</th>																																																	   
															
    
    <th style="text-align:Center ; color:white">حصة الموظف  مساهمةالتكافل</th>
    
<cfif ListFind(attributes.col_option,3,',')OR not len(attributes.col_option)>
      <th style="border:1px solid #000;">الضريبة</th>
	  
	       <cfif isdefined('attributes.ADDdetec') AND LEN(attributes.ADDdetec)> 
   <th style="border:1px solid #000;">سلف مؤقتة</th> 
   <th style="border:1px solid #000;"> سلف مستديمة </th>
   </cfif>
   
      <th style="border:1px solid #000;">الســلف</th>
   </cfif>
   

     <th style="border:1px solid #000;">أجازة بدون راتب مبلغ</th>
    <th style="border:1px solid #000;">مجموع الإستقطاعات</th>
    
   <th style="border:1px solid #000;">الراتب التأميني </th>
   
   <th style="border:1px solid #000;">تامين الأبناء</th>
    <th style="border:1px solid #000;"> أجمالي مخصصات</th>
   <th style="border:1px solid #000;">صــافي الراتب</th> 	
     
 
   </cfif>
    <!---<th >Deductions <br />  Advances</th>--->
    <cfif not len(attributes.col_option)> 
<!---	
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL)>   
   <th style="border:1px solid #000;">تعديل</th>   
   </cfif>
 
--->

<cfif isdefined('attributes.ADDnet') AND LEN(attributes.ADDnet)> 
<th style="border:1px solid #000;"> الراتب<br /> المستحق </th> </cfif>
   <th style="border:1px solid #000;"> المستــحق<br /> الر اتب </th>
   </cfif>

   <cfif isdefined('attributes.ADDAdj') AND LEN(attributes.ADDAdj)> 
   <th style="border:1px solid #000;" >ضبط الاختلاف</th>
 </cfif>
 <cfif attributes.Table neq 2>
     <th style="border:1px solid #000;"></th>
      <cfoutput query="GET_ALLOCATION_PROJECT">
     <cfset 'M_#currentrow#'=0>
      <cfset 'T_#currentrow#_1'=0>
	  <cfset 'T_#currentrow#_2'=0>
      <th style="border:1px solid ##000;text-align:center">#replace(replace(ALLOCATION_NAME,' ','<br>','all'),'/','<br>','all')#<cfif FIND('YEM Service',ALLOCATION_NAME)><BR />#ALLOCATION_NO#</cfif></th> 
      
	 </cfoutput>
    <th style="border:1px solid #000; text-align:center;">الاجمالي</th>
  
     <cfelse>
      <cfif ListFind(attributes.Grant_option,1,',')>  
     <cfoutput query="GET_ALLOCATION_PROJECT">
     <cfset 'M_#currentrow#'=0>
      <cfset 'T_#currentrow#_1'=0>
	  <cfset 'T_#currentrow#_2'=0>
      <th style="background:##95B3D7;border:1px solid ##000;text-align:center">#replace(replace(ALLOCATION_NAME,' ','<br>','all'),'/','<br>','all')#<cfif FIND('YEM Service',ALLOCATION_NAME)><BR />#ALLOCATION_NO#</cfif></th> 
      
	 </cfoutput>
    <th style="background:#95B3D7;border:1px solid #000; text-align:center;">الاجمالي</th>
    </cfif>
     <cfif ListFind(attributes.Grant_option,2,',')>  
    <cfoutput query="GET_ALLOCATION_PROJECT">
       <th style="background:##DA9694;border:1px solid ##000;text-align:center">#replace(replace(ALLOCATION_NAME,' ','<br>','all'),'/','<br>','all')#<cfif FIND('YEM Service',ALLOCATION_NAME)><BR />#ALLOCATION_NO#</cfif></th> 
    </cfoutput>
     <th style="background:#DA9694;border:1px solid #000; text-align:center;">اجمالي</th>
     </cfif>
      <cfif ListFind(attributes.Grant_option,3,',')>  
     <cfoutput query="GET_ALLOCATION_PROJECT">
       <th style="background:##D9D9D9;border:1px solid ##000;text-align:center">#replace(replace(ALLOCATION_NAME,' ','<br>','all'),'/','<br>','all')#<cfif FIND('YEM Service',ALLOCATION_NAME)><BR />#ALLOCATION_NO#</cfif></th> 
    </cfoutput>
     <th style="background:#D9D9D9;border:1px solid #000; text-align:center;">الاحمالي</th>
     </cfif>
    </cfif>
    
    </tr>
        </thead>
    </cfif>
    <tbody>
    <cfif isdefined("attributes.is_form_submitted")>




    <cfif listfind('1,2,4',attributes.Type_id) AND ((isdefined('attributes.new_staff') AND LEN(attributes.new_staff)) or (isdefined('attributes.changed_staff') AND LEN(attributes.changed_staff)))>
    <cfquery name="CHANGED_STAFF1" datasource="#dsn#">
                 SELECT EMPLOYEE_POSITIONS_CHANGE_HISTORY.EMPLOYEE_ID 
                 FROM EMPLOYEE_POSITIONS_CHANGE_HISTORY 
                 WHERE
                 (SELECT top(1) M#Prev_MON# FROM EMPLOYEES_SALARY WHERE EMPLOYEE_ID=EMPLOYEE_POSITIONS_CHANGE_HISTORY.EMPLOYEE_ID AND PERIOD_YEAR=#Prev_YEAR#) IS NOT NULL
                 AND
                 (SELECT top(1) M#Prev_MON# FROM EMPLOYEES_SALARY WHERE EMPLOYEES_SALARY.EMPLOYEE_ID=EMPLOYEE_POSITIONS_CHANGE_HISTORY.EMPLOYEE_ID AND PERIOD_YEAR=#Prev_YEAR#) <> (SELECT top(1) M#attributes.sal_mon# FROM EMPLOYEES_SALARY WHERE EMPLOYEES_SALARY.EMPLOYEE_ID=EMPLOYEE_POSITIONS_CHANGE_HISTORY.EMPLOYEE_ID AND PERIOD_YEAR=#attributes.sal_year#)
                 </cfquery>
                 <cfquery name="CHANGED_STAFF2" datasource="#dsn#">
                 SELECT EMPLOYEE_ID 
                 FROM EMPLOYEES_IN_OUT 
                 WHERE
                  MONTH(START_DATE)=#attributes.sal_mon# AND YEAR(START_DATE)=#attributes.sal_year# 
                 </cfquery>
      <cfset CHANGED_STAFF_LIST='0'>
      <cfset NEW_STAFF_LIST='0'>
      <cfif CHANGED_STAFF1.RECORDCOUNT>
      <cfset CHANGED_STAFF_LIST= VALUELIST(CHANGED_STAFF1.EMPLOYEE_ID)>
      </cfif>
      <cfif CHANGED_STAFF2.RECORDCOUNT>
      <cfset NEW_STAFF_LIST= VALUELIST(CHANGED_STAFF2.EMPLOYEE_ID)>
      </cfif>
      <cfquery name="GET_STAFF" dbtype="query">
        SELECT * FROM get_puantaj_rows
        WHERE 
        <cfif isdefined('attributes.new_staff') AND LEN(attributes.new_staff) AND isdefined('attributes.changed_staff') AND LEN(attributes.changed_staff)>
        (
         EMPLOYEE_ID IN (#CHANGED_STAFF_LIST#)
        )
        OR
        (
           EMPLOYEE_ID IN (#NEW_STAFF_LIST#)
        )
        <cfelseif isdefined('attributes.new_staff') AND LEN(attributes.new_staff)>
        EMPLOYEE_ID IN (#NEW_STAFF_LIST#)
        <cfelse>
        EMPLOYEE_ID IN (#CHANGED_STAFF_LIST#)
        </cfif>
      </cfquery>
      
      <cfset get_puantaj_rows=GET_STAFF>
    </cfif>
        <cfoutput query="get_puantaj_rows" group="#type_#">
            <cfoutput>
            
                <cfset attributes.employee_id = get_puantaj_rows.EMPLOYEE_ID>
                
                
                <cfquery name="get_this_istisna" dbtype="query">
                    SELECT SUM(VERGI_ISTISNA_AMOUNT) AS VERGI_ISTISNA_AMOUNT FROM get_vergi_istisna WHERE EMPLOYEE_PUANTAJ_ID = #EMPLOYEE_PUANTAJ_ID# AND VERGI_ISTISNA_AMOUNT IS NOT NULL
                </cfquery>
                <cfscript>
					if (get_this_istisna.recordcount)
						t_istisna_odenek = get_this_istisna.vergi_istisna_amount;
					maas_ = evaluate("get_puantaj_rows.M#get_puantaj_rows.row_sal_mon#");
				
                    sgk_isci_hissesi_fark = 0;
                    sgk_issizlik_hissesi_fark = 0;
                    sgdp_isci_primi_fark = 0;
                    _issizlik_isci_hissesi_devirsiz = 0;
                    sayac = sayac+1;
                    if (SALARY_TYPE eq 2)
                    {
                        aylik = SALARY;
                        t_aylik_ucret = t_aylik_ucret + SALARY;
                        d_t_aylik_ucret = d_t_aylik_ucret + SALARY;
                    }
                    else if (SALARY_TYPE eq 1)
                    {
                        aylik = SALARY;
                        t_aylik_ucret = t_aylik_ucret + SALARY;
                        d_t_aylik_ucret = d_t_aylik_ucret + SALARY;
                    }
                    else if (SALARY_TYPE eq 0)
                    {
                        aylik = (SALARY*SSK_WORK_HOURS*MONTH_DAYS);
                        t_aylik_ucret = t_aylik_ucret + (SALARY*SSK_WORK_HOURS*MONTH_DAYS);
                        d_t_aylik_ucret = d_t_aylik_ucret + (SALARY*SSK_WORK_HOURS*MONTH_DAYS);
                    } 
                    if(len(weekly_hour))
                        t_hi_saat = t_hi_saat + weekly_hour;
                    if(len(weekend_hour))
                        t_ht_saat = t_ht_saat + weekend_hour;
                    if(len(offdays_count_hour))
                        t_gt_saat = t_gt_saat + offdays_count_hour;					
                    if(len(paid_izinli_sunday_count_hour))
                        t_paid_ht_izin_saat = t_paid_ht_izin_saat + paid_izinli_sunday_count_hour;
                    t_saat = weekly_hour + weekend_hour + offdays_count_hour + izin_paid_count + paid_izinli_sunday_count_hour - paid_izinli_sunday_count_hour;
                    gt_hi_saat = gt_hi_saat + t_hi_saat;								
                    gt_ht_saat = gt_ht_saat + t_ht_saat;								
                    gt_gt_saat = gt_gt_saat + t_gt_saat;								
                    gt_paid_ht_izin_saat = gt_paid_ht_izin_saat + t_paid_ht_izin_saat;	
                    gt_toplam_saat = gt_toplam_saat + t_saat;						
                    gt_gece_mesai_saat = gt_gece_mesai_saat + EXT_TOTAL_HOURS_5;
                    t_gece_mesai_saat = t_gece_mesai_saat + EXT_TOTAL_HOURS_5;
                    t_paid_izin_saat = t_paid_izin_saat + izin_paid_count-paid_izinli_sunday_count_hour;
                    gt_paid_izin_saat = gt_paid_izin_saat + izin_paid_count-paid_izinli_sunday_count_hour;			
                    t_izin = t_izin + izin;
                    d_t_izin = d_t_izin + izin;
                    gt_izin_saat = gt_izin_saat + izin_count;	
                    dt_izin_saat = dt_izin_saat + izin_count;							
                    onceki_donem_kum_gelir_vergisi_matrahi = KUMULATIF_GELIR_MATRAH - gelir_vergisi_matrah;
                    if(onceki_donem_kum_gelir_vergisi_matrahi lt 0)

                        onceki_donem_kum_gelir_vergisi_matrahi = 0;
            
                    //t_toplam_kazanc = t_toplam_kazanc + total_salary+VERGI_ISTISNA_AMOUNT;
                    //t_toplam_kazanc = t_toplam_kazanc + TOTAL_SALARY -VERGI_ISTISNA_SSK;
                    t_toplam_kazanc = t_toplam_kazanc + (total_salary-VERGI_ISTISNA_SSK-VERGI_ISTISNA_VERGI+VERGI_ISTISNA_AMOUNT_);
                    t_vergi_indirimi = t_vergi_indirimi + vergi_indirimi;
                    t_sakatlik_indirimi = t_sakatlik_indirimi + sakatlik_indirimi;
                    t_kum_gelir_vergisi_matrahi =  t_kum_gelir_vergisi_matrahi + KUMULATIF_GELIR_MATRAH ;
                    t_onceki_donem_kum_gelir_vergisi_matrahi = t_onceki_donem_kum_gelir_vergisi_matrahi + onceki_donem_kum_gelir_vergisi_matrahi;
                    t_gelir_vergisi_matrahi = t_gelir_vergisi_matrahi + gelir_vergisi_matrah;
                    t_gelir_vergisi = 0;
                    t_asgari_gecim =0;
                    
                    d_t_toplam_kazanc = 0;
                    d_t_vergi_indirimi = 0;
                    d_t_sakatlik_indirimi = 0;
                    d_t_kum_gelir_vergisi_matrahi = 0;
                    d_t_onceki_donem_kum_gelir_vergisi_matrahi = 0;
                    d_t_gelir_vergisi_matrahi = 0;
                     d_t_gelir_vergisi = 0;
                    d_t_asgari_gecim = 0;
                    
                    if(not len(mahsup_g_vergisi))
                        mahsup_g_vergisi_ = 0;
                    else 
                        mahsup_g_vergisi_ = mahsup_g_vergisi;
                        
                    t_mahsup_g_vergisi = t_mahsup_g_vergisi + mahsup_g_vergisi_;
                    t_gelir_vergisi_indirimi_5746 = t_gelir_vergisi_indirimi_5746 + gelir_vergisi_indirimi_5746;
                    if(is_5746_control eq 0) //arge indiriminin gelir vergisinden düşülmemesi ile ilgili toplam icmal icin eklendi //SG 20140306
                    {                
                        t_gelir_vergisi_indirimi_5746_ = 0;
                    }
                    t_gelir_vergisi_indirimi_4691 = 0;
				    if(is_4691_control eq 0) //arge indiriminin gelir vergisinden düşülmemesi ile ilgili toplam icmal icin eklendi
                    {                
                        t_gelir_vergisi_indirimi_4691_ = 0;
                    }
                    t_damga_vergisi_matrahi =0;
                    t_damga_vergisi = 0;
                    t_kesinti = 0;
                    t_net_ucret =0;
                    t_vergi_iadesi =0;
                    t_kidem_isveren_payi = 0;
                    t_kidem_isci_payi =0;
                    t_total_pay_ssk_tax = 0;
                    t_total_pay_ssk = 0;
                    t_total_pay_tax = 0;
                    t_total_pay = 0;
                    t_ozel_kesinti =0;
                    
                    d_t_mahsup_g_vergisi = 0;
                    d_t_gelir_vergisi_indirimi_5746 =0;
                    if(is_5746_control eq 0) //arge indiriminin gelir vergisinden düşülmemesi ile ilgili toplam icmal icin eklendi //SG 20140306
                    {
                        d_t_gelir_vergisi_indirimi_5746_ = 0;
                    }
                    d_t_gelir_vergisi_indirimi_4691 = 0;
                    if(is_4691_control eq 0) //arge indiriminin gelir vergisinden düşülmemesi ile ilgili toplam icmal icin eklendi
                    {
                        d_t_gelir_vergisi_indirimi_4691_ = 0;
                    }
                    d_t_damga_vergisi_matrahi = 0;             	
                    d_t_damga_vergisi = 0;
                    d_t_kesinti = 0;
                   

	d_t_net_with=d_t_net_with + numberFormat( ISSIZLIK_ISVEREN_HISSESI_7103,'__.000');;
	d_t_diff=0;
	d_t_adv=0;
				   d_t_net_ucret = d_t_net_ucret + net_ucret;
                    d_t_kidem_isveren_payi = d_t_kidem_isveren_payi + kidem_boss;
                    d_t_kidem_isci_payi = d_t_kidem_isci_payi + kidem_worker;
					d_t_TOTAL_DAYS = d_t_TOTAL_DAYS + TOTAL_DAYS;
                    d_t_total_pay_ssk_tax = d_t_total_pay_ssk_tax + total_pay_ssk_tax;
					d_t_DAMGA_VERGISI_MATRAH= d_t_DAMGA_VERGISI_MATRAH + DAMGA_VERGISI_MATRAH;
					d_t_DAMGA_VERGISI_MATRAH_days=d_t_DAMGA_VERGISI_MATRAH_days+DAMGA_VERGISI_MATRAH/MONTH_DAYS*TOTAL_DAYS;
                    d_t_total_pay_ssk = d_t_total_pay_ssk + total_pay_ssk;
                    d_t_total_pay_tax = d_t_total_pay_tax + total_pay_tax;
                    d_t_total_pay = d_t_total_pay + total_pay;
                    d_t_ozel_kesinti = d_t_ozel_kesinti + ozel_kesinti;
                    
					
                    if (len(OFFDAYS_COUNT)) 
                        OFFDAYS_COUNT_ = OFFDAYS_COUNT;
                    else
                        OFFDAYS_COUNT_ = 0;
                    if (len(OFFDAYS_SUNDAY_COUNT)) 
                        OFFDAYS_SUNDAY_COUNT_ = OFFDAYS_SUNDAY_COUNT;
                    else
                        OFFDAYS_SUNDAY_COUNT_ = 0;
                    
                    t_offdays = t_offdays + OFFDAYS_COUNT_;
                    t_offdays_sundays = t_offdays_sundays + OFFDAYS_SUNDAY_COUNT_;
                    t_paid_izinli_sunday_count = t_paid_izinli_sunday_count + paid_izinli_sunday_count;
                    t_sundays = t_sundays + sunday_count;
                    t_kanun = t_kanun + VERGI_INDIRIMI_5084;
                    //t_maas = t_maas + maas;
                    t_maas = t_maas + maas_;
                    
                    d_t_offdays = d_t_offdays + OFFDAYS_COUNT_;
                    d_t_offdays_sundays = d_t_offdays_sundays + OFFDAYS_SUNDAY_COUNT_;
                    d_t_paid_izinli_sunday_count = d_t_paid_izinli_sunday_count + paid_izinli_sunday_count;
                    d_t_sundays = d_t_sundays + sunday_count;
                    d_t_kanun = d_t_kanun + VERGI_INDIRIMI_5084;
                    //d_t_maas = d_t_maas + maas;
                    d_t_maas = d_t_maas + maas_;
            
                    ssk_devir_toplam = 0;
            
                    if(len(trim(ssk_devir)))
                    {
                        ssk_devir_ = ssk_devir;
                        ssk_devir_toplam = ssk_devir_toplam + ssk_devir;
                    }
                    else
                       { ssk_devir_ = 0;}
                        
                    if(len(trim(ssk_devir_last)))
                    {
                        ssk_devir_last_ = ssk_devir_last;
                        ssk_devir_toplam = ssk_devir_toplam + ssk_devir_last;
                    }
                    else
                       { ssk_devir_last_ = 0;}
                        
                    if(len(trim(ssk_devir)))
                    { 
                        d_t_ssk_devir = d_t_ssk_devir + ssk_devir;
                        t_ssk_devir = t_ssk_devir + ssk_devir;
                    }
                    if(len(trim(ssk_devir_last)))
                    {
                        d_t_ssk_devir_last = d_t_ssk_devir_last + ssk_devir_last;
                        t_ssk_devir_last = t_ssk_devir_last + ssk_devir_last;
                    }
                    d_t_ssk_amount = d_t_ssk_amount + ssk_amount; 
                    
                    t_ssk_amount =  t_ssk_amount + ssk_amount;
					
					d_t_bes_isci_hissesi = 0;
					t_bes_isci_hissesi = 0;
                    
                    if (ssdf_isci_hissesi gt 1)
                    {
                        t_ssdf_ssk_days = t_ssdf_ssk_days + total_days;
                        t_ssdf_days = t_ssdf_days + total_days - sunday_count;
                        t_ssdf_matrah = t_ssdf_matrah + SSK_MATRAH;
                        t_ssdf_isci_hissesi = t_ssdf_isci_hissesi + ssdf_isci_hissesi;
                        t_ssdf_isveren_hissesi = t_ssdf_isveren_hissesi + ssdf_isveren_hissesi;
                        isveren_b_5510_ = 0;
                        ssk_isveren_hissesi_5510_ = 0;
                        
                        d_t_ssdf_ssk_days = d_t_ssdf_ssk_days + total_days;
                        d_t_ssdf_days = d_t_ssdf_days + total_days - sunday_count;
                        d_t_ssdf_matrah = d_t_ssdf_matrah + SSK_MATRAH;
                        d_t_ssdf_isci_hissesi = d_t_ssdf_isci_hissesi + ssdf_isci_hissesi;
                        d_t_ssdf_isveren_hissesi = d_t_ssdf_isveren_hissesi + ssdf_isveren_hissesi;
            
                        if(Len(SSK_ISCI_HISSESI_DUSULECEK))
                            sgdp_isci_primi_fark = SSK_ISCI_HISSESI_DUSULECEK;
            
                        t_sgdp_isci_primi_fark = t_sgdp_isci_primi_fark + sgdp_isci_primi_fark;
                        d_t_sgdp_isci_primi_fark = d_t_sgdp_isci_primi_fark + sgdp_isci_primi_fark;
                        isveren_hesaplanan = 0;
                    }
                    else
                    {
                        t_ssk_days = t_ssk_days + total_days;
                        t_work_days = t_work_days + total_days - sunday_count;
            
                        if (use_ssk eq 0)
                        {
                            t_ssk_primi_isci = 0;
            
                            t_ssk_matrahi =0;
            
                            if(ssk_isci_hissesi gt 0 and ssk_devir_toplam gt 0)
                                t_ssk_primi_isci_devirsiz = 0;
                            else
                                t_ssk_primi_isci_devirsiz =0;
            
                            if(issizlik_isci_hissesi gt 0 and ssk_devir_toplam gt 0)
                                _issizlik_isci_hissesi_devirsiz = 0;
                            else
                                _issizlik_isci_hissesi_devirsiz = 0;
            
                            sgk_isci_hissesi_fark = 0;
                            sgk_issizlik_hissesi_fark = 0;
            
                            t_sgk_isci_hissesi_fark = 0;
                            t_sgk_issizlik_hissesi_fark = 0;
            
                            d_t_sgk_isci_hissesi_fark = 0;
                            d_t_sgk_issizlik_hissesi_fark = 0;
                        }
                        ssk_isveren_hissesi_5510_ = 0;
                        
                        isveren_hesaplanan = 0;
                        if(ssk_isci_hissesi eq 0)t_ssk_primi_isveren_hesaplanan = t_ssk_primi_isveren_hesaplanan + ssdf_isveren_hissesi;else t_ssk_primi_isveren_hesaplanan = t_ssk_primi_isveren_hesaplanan + isveren_hesaplanan;
                        
                        
                        t_ssk_primi_isveren_5510 = 0;
                        t_ssk_primi_isveren_5084 = 0;
                                    
                        t_ssk_primi_isveren_5921 = 0;
                        t_ssk_primi_isveren_5746 = 0;
                        t_ssk_primi_isveren_4691 = 0;
                        if(len(ssk_isveren_hissesi_6111))
                            t_ssk_primi_isveren_6111 = 0;
                        else
                            ssk_isveren_hissesi_6111 = 0;
                            
                        if(len(ssk_isveren_hissesi_6486))
                            t_ssk_primi_isveren_6486 = 0;
                        else
                            ssk_isveren_hissesi_6486 = 0;
                        
                        if(len(ssk_isveren_hissesi_6322))
                            t_ssk_primi_isveren_6322 = 0;
                        else
                            ssk_isveren_hissesi_6322 = 0;
                        if(len(ssk_isci_hissesi_6322))
                            t_ssk_primi_isci_6322 = t_ssk_primi_isci_6322 + ssk_isci_hissesi_6322;
                        else
                            ssk_isci_hissesi_6322 = 0;
							
						if(len(ssk_isveren_hissesi_14857))
							t_ssk_primi_isveren_14857 = 0;
						else
							t_ssk_primi_isveren_14857 = 0;	
						
                        t_ssk_primi_isveren_gov = 0;
                        
						t_ssk_isveren_hissesi_687 = 0;
						t_ssk_isci_hissesi_687 = 0;
						t_issizlik_isci_hissesi_687 = 0;
						t_issizlik_isveren_hissesi_687 = 0;
						t_gelir_vergisi_indirimi_687 = 0;
						t_damga_vergisi_indirimi_687 = 0;
						
						t_ssk_isveren_hissesi_7103 = 0;
						t_ssk_isci_hissesi_7103 = 0;
						t_issizlik_isci_hissesi_7103 = 0;
						t_issizlik_isveren_hissesi_7103 = 0;
						t_gelir_vergisi_indirimi_7103 = 0;
						t_damga_vergisi_indirimi_7103 =0;
						
						
                        t_issizlik_isci_hissesi = 0;
                        t_issizlik_isveren_hissesi =0;
                        
                        d_t_ssk_days =0;
                        d_t_work_days = 0;
                        d_t_ssk_matrahi =0;
                        d_t_ssk_primi_isci = 0;
                        
                        if(ssk_isci_hissesi eq 0)d_t_ssk_primi_isveren_hesaplanan = 0;
                        
                        d_t_ssk_primi_isveren_5510 = 0;
                        d_t_ssk_primi_isveren_5084 = 0;
                                    
                        d_t_ssk_primi_isveren_5921 = 0;
                        d_t_ssk_primi_isveren_5746 = 0;
                        d_t_ssk_primi_isveren_4691 = 0;
                        
                        if(len(ssk_isveren_hissesi_6111))
                            d_t_ssk_primi_isveren_6111 = 0;
                        
                        if(len(ssk_isveren_hissesi_6486))
                            d_t_ssk_primi_isveren_6486 =0;
                        
                        if(len(ssk_isveren_hissesi_6322))
                            d_t_ssk_primi_isveren_6322 =0;
                        if(len(ssk_isci_hissesi_6322))
                            d_t_ssk_primi_isci_6322 = 0;
							
						if(len(ssk_isveren_hissesi_14857))	
							d_t_ssk_primi_isveren_14857 = 0;
						else
							d_t_ssk_primi_isveren_14857 = 0;
							
                        d_t_ssk_primi_isveren_gov = 0;
            
			
						d_t_ssk_isveren_hissesi_687 = 0;
						d_t_ssk_isci_hissesi_687 = 0;
						d_t_issizlik_isci_hissesi_687 = 0;
						d_t_issizlik_isveren_hissesi_687 = 0;
						d_t_gelir_vergisi_indirimi_687 = 0;
						d_t_damga_vergisi_indirimi_687 = 0;
						
						d_t_ssk_isveren_hissesi_7103 = 0;
						d_t_ssk_isci_hissesi_7103 = 0;
						d_t_issizlik_isci_hissesi_7103 = 0;
						d_t_issizlik_isveren_hissesi_7103 =0;
						d_t_gelir_vergisi_indirimi_7103 = 0;
						d_t_damga_vergisi_indirimi_7103 = 0;
						
                        d_t_issizlik_isci_hissesi = 0;
                        d_t_issizlik_isveren_hissesi =0;
            
                        d_t_ssk_primi_isveren = 0;
            
                        t_ssk_primi_isveren = 0;		
                    }
                    devir_tutar_ = 0;
                    if(len(SSK_ISCI_HISSESI_DUSULECEK))
                        devir_tutar_ = 0;
                        
                    if(len(ISSIZLIK_ISCI_HISSESI_DUSULECEK))
                        devir_tutar_ = 0;
                        
                    t_devir_fark = 0;
                    d_t_devir_fark = 0;
        
                    //toplam_isveren_indirimsiz = devir_tutar_ + total_salary+t_istisna_odenek+issizlik_isveren_hissesi+ssk_isveren_hissesi+ssdf_isveren_hissesi + ssk_isveren_hissesi_5510 - VERGI_ISTISNA_VERGI;
                    toplam_isveren_indirimsiz = 0;
				   
				    //687 tesvikten düsülecekler
					toplam_indirim_687 = 0;
				   
					//7103 tesvikten düsülecekler
					toplam_indirim_7103 = 0;
				   
                    toplam_isveren = 0;
                    t_toplam_isveren = 0;
                    d_t_toplam_isveren = 0;
                    t_toplam_isveren_indirimsiz =0;
                    d_t_toplam_isveren_indirimsiz = 0;
                    d_kidem_amount = 0;
                    d_ihbar_amount = 0;
                    t_kidem_amount =0;
                    t_ihbar_amount = 0;
                    d_vergi_istisna_total = 0;
                    d_vergi_istisna_ssk = 0;
                    d_vergi_istisna_ssk_net = 0;
                    d_vergi_istisna_vergi = 0;
                    d_vergi_istisna_vergi_net =0;
                    d_vergi_istisna_damga = 0;
                    d_vergi_istisna_damga_net = 0;
                    
                    t_vergi_istisna_total = t_vergi_istisna_total + vergi_istisna_total;
                    t_vergi_istisna_ssk = t_vergi_istisna_ssk + vergi_istisna_ssk;
                    t_vergi_istisna_ssk_net = t_vergi_istisna_ssk_net + vergi_istisna_ssk_net;
                    t_vergi_istisna_vergi = t_vergi_istisna_vergi + vergi_istisna_vergi;
                    t_vergi_istisna_vergi_net = t_vergi_istisna_vergi_net + vergi_istisna_vergi_net;
                    t_vergi_istisna_damga = t_vergi_istisna_damga + vergi_istisna_damga;
                    t_vergi_istisna_damga_net = t_vergi_istisna_damga_net + vergi_istisna_damga_net;
                    if(ssk_isci_hissesi gt 0)
                    {
                        t_sgk_isveren_hissesi = 0;

                        d_t_sgk_isveren_hissesi =0;
                    }
					
					haftalik_tatil = weekend_day;
					normal_gun = ceiling(weekly_day);
					normal_izinli = izin_paid - paid_izinli_sunday_count;
					genel_tatil = OFFDAYS_COUNT;
					yillik_izin = YILLIK_IZIN_AMOUNT;
					if (normal_gun lt 0)
						normal_gun = 0;
					normal_gun_total = normal_gun + normal_gun_total;
					haftalik_tatil_total = haftalik_tatil + haftalik_tatil_total;
					genel_tatil_total = genel_tatil + genel_tatil_total;
					izin_total = izin_total + izin;
					yillik_izin_total = yillik_izin + yillik_izin_total;
					d_normal_gun_total = normal_gun + d_normal_gun_total;
					d_haftalik_tatil_total = haftalik_tatil + d_haftalik_tatil_total;
					d_genel_tatil_total = genel_tatil + d_genel_tatil_total;
					d_izin_total = d_izin_total + izin;
					d_yillik_izin_total = yillik_izin + d_yillik_izin_total;
					if (total_salary)
					{
						if (SALARY_TYPE eq 2)
							ucretim = SALARY/MONTH_DAYS;
						else if (SALARY_TYPE eq 1)
							ucretim = SALARY;
						else if (SALARY_TYPE eq 0)
							ucretim = SALARY*SSK_WORK_HOURS;
					}
					else
						ucretim = total_salary;
					t_gunluk_ucret = t_gunluk_ucret + ucretim;
					d_t_gunluk_ucret = d_t_gunluk_ucret + ucretim;
					d_t_izin_paid = d_t_izin_paid + normal_izinli;
					t_izin_paid = t_izin_paid + normal_izinli;
					t_aylik = t_aylik + total_amount;
					t_aylik_fazla = t_aylik_fazla + ext_salary;
					t_aylik_fazla_mesai_net = t_aylik_fazla_mesai_net + ext_salary_net;
					d_t_aylik = d_t_aylik + total_amount;
					d_t_aylik_fazla = d_t_aylik_fazla + ext_salary;
					d_t_aylik_fazla_mesai_net = d_t_aylik_fazla_mesai_net + ext_salary_net;
					aylik_brut_ucret = total_amount-ext_salary-YILLIK_IZIN_AMOUNT-KIDEM_AMOUNT-IHBAR_AMOUNT;
					t_aylik_brut_ucret = t_aylik_brut_ucret+aylik_brut_ucret;
                </cfscript>
                <tr style="height:25">
                <cfset row_color="border:1px solid ##000;">
                 <cfif len(attributes.Type_id) and attributes.Type_id neq 3 AND isdefined('attributes.with_color') and len(attributes.with_color)> 
                  <cfquery name="NEW_PERMOTION_salary" datasource="#dsn#">
                   SELECT M#Prev_MON# FROM EMPLOYEES_SALARY 
                   WHERE EMPLOYEE_ID=#EMPLOYEE_ID# AND 
                   IN_OUT_ID = #IN_OUT_ID# AND
                   PERIOD_YEAR=#Prev_YEAR# AND 
                   M#Prev_MON# IS NOT NULL AND 
                   M#Prev_MON# <> #SALARY#
                 </cfquery>
                 <cfif len(start_date) and (month(start_date) eq row_sal_mon and year(start_date) eq row_sal_year)>
                 <cfset row_color="background:##EBE600;"&"border:1px solid ##000;">
                 <cfelseif NEW_PERMOTION_salary.recordcount>
                 <cfset row_color="background:##FFC000;"&"border:1px solid ##000;">
                 </cfif>
               </cfif>
                  <cfset ssk_count = ssk_count+1>
                  <!---<cfloop list="#attributes.b_obj_hidden_new#" index="xlr">--->
      <cfif isDefined("attributes.is_title") or isDefined("attributes.is_position_cat_id") or isDefined("attributes.is_position") or isDefined("attributes.is_position_fonksiyon") or isDefined("attributes.is_p_branch_name") or isDefined("attributes.is_p_department_name")>
        <cfquery dbtype="query" name="position_info">
	SELECT * FROM get_position_info WHERE EMPLOYEE_ID = #EMPLOYEE_ID#
	</cfquery>
      </cfif>
      <cfquery name="bank_info" datasource="#dsn#">
    SELECT
    	BANK_ACCOUNT_NO,
        MONEY
    FROM EMPLOYEES_BANK_ACCOUNTS
    WHERE
    	EMPLOYEE_ID = #EMPLOYEE_ID#
</cfquery>
<cfquery name="FUNC_info" datasource="#dsn#">
 SELECT *   FROM [SETUP_CV_UNIT] 

 </cfquery>



<cfscript>
		get_puantaj_1 = createObject("component", "v16.hr.ehesap.cfc.Ytech_Putan");
	
		
		epr = get_puantaj_1.emp_pun1
		(
			sal_year : attributes.sal_year,
			sal_mon : attributes.sal_mon,
			employee_id :#EMPLOYEE_ID#
			
		);
	</cfscript>

<cfset Gl_Aden_USD = ( epr.GELIR_VERGISI_INDIRIMI_7103 / epr.DAMGA_VERGISI_INDIRIMI_7103)>

  <!---1---> <td rowspan="#coloption#" style="#row_color#width:10;">#CURRENTROW#</td>
  <!---2--->     <td rowspan="#coloption#"  style="#row_color#width:10;" >#EMPLOYEE_NO#</td>
  <!---3   <td rowspan="#coloption#"  style="#row_color#width:10;"  >#FUNC_info.UNIT_NAME#</td>   
 <td rowspan="#coloption#"  style="#row_color#width:10;"  >#FUNC_info.UNIT_DETAIL#</td> --->
  <!---5--->     <td rowspan="#coloption#"  style="#row_color#width:10;">#EMPLOYEE_NAME# #EMPLOYEE_SURNAME#</td> 
  <!---4--->    <!--- <td rowspan="#coloption#" style="#row_color#width:10;"  >#DEPARTMENT_HEAD#</td>

  <!---6--->    <td rowspan="#coloption#"  style="#row_color#"  >#POSITION_NAME#</td>
  <!---7--->    <td rowspan="#coloption#"  style="#row_color#"  > #BRANCH_NAME#</td>--->
         <cfif not len(attributes.col_option)> 
  <!---8     <td rowspan="#coloption#"  style="#row_color#" >#bank_info.BANK_ACCOUNT_NO#</td>--->
  <!---9--->     <td rowspan="#coloption#"  style="#row_color#; text-align:center">#TOTAL_DAYS#</td>
       
  <!---10--->    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Basic salary">#tlformat((epr.base_salary))#</td>
<cfSET t_salba_sum = t_salba_sum + numberFormat((epr.base_salary),"000")>
  <!---11---><td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Trans_allow">#tlformat((epr.Trans_allow ))#</td>
 <cfSET t_Tran_sum = t_Tran_sum + numberFormat((epr.Trans_allow),"000")>
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title=".20%">#KIDEM_BOSS#</td>
 <cfSET t_Rep_sum = t_Rep_sum + KIDEM_BOSS>
  <!---12--->     <td rowspan="#coloption#"  style="#row_color#; text-align:center" title=".25%">#tlformat((epr.Repres_allow ))#</td>
<cfSET  t_Repres_sum = t_Repres_sum + numberFormat((epr.Repres_allow),"000")>

    <td rowspan="#coloption#"  style="#row_color#; text-align:center"  title="allowances">#tlformat((epr.Mature_of_work ))#</td>
  <cfSET   t_nature_sum1  = t_nature_sum1 +numberFormat((epr.Mature_of_work),"000")>

  <!---13--->     <td rowspan="#coloption#"  style="#row_color#; text-align:center"  title="allowances">#tlformat((epr.Gross_salary ))#</td>
   <cfSET   t_Grosss_sum  = t_Grosss_sum + numberFormat((epr.Gross_salary  ),"000")>
  <!---13--2---> 

  

                   <cfquery name="ZainabP" datasource="#dsn#">
	                    	SELECT  TOP 1  ACCOUNT_BILL_TYPE payroll_id  FROM EMPLOYEES_IN_OUT_PERIOD
	                      	where in_out_id=#get_puantaj_rows.in_out_id#  and PERIOD_COMPANY_ID= #session.ep.company_id# AND PERIOD_YEAR=#attributes.sal_year# order by row_id desc
                   </cfquery>
<!---<script> alert('<cfoutput>xe#ZainabP.PAYROLL_ID# </cfoutput>');</script>---->
                   <cfquery name="ZainabPR" datasource="#dsn#">
   
                     select INOUT_ROW_ID , EXPENSE_CENTER_ID , Rate,IN_OUT_ID FROM [EMPLOYEES_IN_OUT_PERIOD_ROW]
                     where  in_out_id=#get_puantaj_rows.in_out_id# --and 
                   ---    INOUT_ROW_ID in ( select ROW_ID  FROM [wrk_rgyemen].[wrk_rgyemen].EMPLOYEES_IN_OUT_PERIOD
                   ---    where PERIOD_COMPANY_ID= #session.ep.company_id# AND PERIOD_YEAR=#attributes.sal_year#
                   ---            )
                         </cfquery>
                       <!--- <script> alert('<cfoutput>دخول#ZainabPR.EXPENSE_CENTER_ID#</cfoutput>');</script>--->
						<cfif  ZainabP.recordcount   > <cfif  ZainabPR.recordcount>
						<cfloop query="ZainabPR">
                     <cfset 'gross_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('gross_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Gross_salary/100 * #rate#  ),"000")> 
					 <cfset 'SSK9_company_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('SSK9_company_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.SSK9_company/100 * #rate#),"000")>
					 <cfset 'tr_01_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('tr_01_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.tr_01/100 * #rate#),"000")>
					<cfset 'SSK15c_company_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('SSK15c_company_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.SSK15c_company/100 * #rate#),"000")>
					
					<cfset 'Transportation_allowances_Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Transportation_allowances_Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Transportation_allowances_Incentive/100 * #rate#),"000")>
                    <cfset 'Call_allowance_Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Call_allowance_Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Call_allowance_Incentive/100 * #rate#),"000")>
					<cfset 'Cashier_allowance_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Cashier_allowance_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Cashier_allowance/100 * #rate#),"000")>
					<cfset 'Area_Allowance_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Area_Allowance_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Area_Allowance/100 * #rate#),"000")>
					<cfset 'Full_Allowance_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Full_Allowance_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Full_Allowance/100 * #rate#),"000")>
                    <cfset 'Incentive_and_Supervision_allowance_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Incentive_and_Supervision_allowance_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Incentive_and_Supervision_allowance/100 * #rate#),"000")>
					<cfset 'Nature_of_work_control_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Nature_of_work_control_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Nature_of_work_control/100 * #rate#),"000")>
                    <cfset 'An_incentive_instead_of_risk_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('An_incentive_instead_of_risk_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.An_incentive_instead_of_risk/100 * #rate#),"000")>
					<cfset 'Feed_allowance_Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Feed_allowance_Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Feed_allowance_Incentive/100 * #rate#),"000")>
                    <cfset 'Nature_of_work_Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Nature_of_work_Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Nature_of_work_Incentive/100 * #rate#),"000")>
					<cfset 'Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL'= evaluate('Incentive_#ZainabP.PAYROLL_ID#_#ZainabPR.EXPENSE_CENTER_ID#_TOTAL') + numberFormat((epr.Incentive/100 * #rate#),"000")>
                    
					
					</cfloop>
      </cfif>
      </cfif>
</cfif>

 <cfset t_Dedec_Gl1= t_Dedec_Gl1 + numberFormat((epr.SSK01_company),"0.00") >
 <cfset t_Dedec_gl2=  t_Dedec_gl2 + numberFormat((epr.absent_days),"0.00")>
 <cfset t_Dedec_gl3=  t_Dedec_gl3 + numberFormat((epr.Eid_Absent1),"00.00")>
 <cfset t_Dedec_gl4=  t_Dedec_gl4 + numberFormat((epr.Health_Insurance_Premium),"0.00")>
 <cfset t_Dedec_gl5=  t_Dedec_gl5 + numberFormat((epr.Thursday_Ansent),"00.00")>
 <cfset t_Dedec_gl6= t_Dedec_gl6 + numberFormat((epr.Penalties),"00.00")>
 <cfset t_Dedec_gl7= t_Dedec_gl7 + numberFormat((epr.Restaurant_Premium),"00.00")>
 <cfset t_Dedec_gl8= t_Dedec_gl8 + numberFormat((epr.Satarday_Absent),"00.00")>
 <cfset t_Dedec_gl9= t_Dedec_gl9 + numberFormat((epr.tr_01),"0.00") + numberFormat((epr.SSK15c_company),"00.00")>
 <cfset t_Dedec_gl10=  t_Dedec_gl10 + numberFormat((epr.Fighting_cancer),"00.00")>
 <cfset t_Dedec_gl11= t_Dedec_gl11 + numberFormat((epr.tr_01),"00.00")>
 <cfset t_Dedec_g12= t_Dedec_g12 + numberFormat((epr.DIS_VACDAY),"00.00")>
 <cfset t_col2_sum= t_col2_sum + numberFormat((epr.try_6),"00.00")> 
 <!---cfset t_col8_sum= t_col8_sum + numberFormat((epr.DIS_VACDAY),"00.00")---->
 <cfset Ded_gl_total=  t_Dedec_Gl1 + t_Dedec_gl2 +t_Dedec_gl3  + t_Dedec_gl5 + t_Dedec_gl6  + t_Dedec_gl8 + t_Dedec_gl10 + t_Dedec_g12 >
 <cfset One_fimailys_t = One_fimailys_t + numberFormat((epr.One_fimailys),"00.00") >

<cfif ListFind(attributes.col_option,1,',') OR not len(attributes.col_option)>  

  <!---17---> <!---حصة الشركة في الضمان الاختماعي---> 
     <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="INSURANCE COMPANY">#tlformat((epr.SSK9_company))#</td>
  <cfSET t_S.S9_sum =t_S.S9_sum + numberFormat((epr.SSK9_company),"000")>
  </cfif>
    
  <!---حصة التدريب  
  <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="allowances">  #numberFormat(( epr.GELIR_VERGISI_INDIRIMI_7103 / epr.DAMGA_VERGISI_INDIRIMI_7103),"0.000000")#</td>
  
    
  <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="allowances"> GEl #tlformat((Gl_Aden_USD))#</td>
  ---> 
  
<td rowspan="#coloption#"  style="#row_color#; text-align:center" title="allowances">#tlformat((epr.tr_01))#</td>
  <!--- <cfSET   t_S.Skz1_sum  = t_S.Skz1_sum + numberFormat((epr.tr_01),"000")>--->
  <cfset total_z = total_z + numberFormat((epr.tr_01),"000") >
   
  <!---14 --->  <!---صندوق التكامل قسط الشركة --->  
    
<td rowspan="#coloption#"  style="#row_color#; text-align:center"  title="Gross" >#tlformat((epr.SSK15c_company))# </td>
<cfset t_Satax_sum = t_satax_sum  + numberFormat((epr.SSK15c_company),"000")>
  
  
  <!---18--->   <!---حصة الموظف في الضمان الاختماعي--->  
  
<cfif ListFind(attributes.col_option,1,',') OR not len(attributes.col_option)> 
   <td rowspan="#coloption#" style="#row_color#;background:##D9D9D9; text-align:center" title="INSURANCE EMPLOYEE">#tlformat((epr.try_6))#</td>    
  <cfSET t_S.S6_sum =t_S.S6_sum + numberFormat((epr.try_6),"000")>
  <cfset GLins = GLins +  numberFormat((epr.try_6),"0.00") + numberFormat((epr.SSK9_company),"00.00")>
  </cfif>

 <!---15--->   <!---المغادرات--->  
 <td rowspan="#coloption#"  style="#row_color#; text-align:center"  title="Gross" >#tlformat((epr.Delay_minutes))# </td>
<cfset t_SSK011_sum = t_SSK011_sum  + numberFormat((epr.Delay_minutes),"000")>

<td rowspan="#coloption#"  style="#row_color#; text-align:center"  title="Gross" >#tlformat((epr.SSK01_company))# </td>
<cfset t_SSK01_sum = t_SSK01_sum  + numberFormat((epr.SSK01_company),"000")>

 <!---حصة الموظف مساهمة التكافل--->
<td rowspan="#coloption#"  style="#row_color#; text-align:center" title="allowances">#tlformat((epr.tr_01))#</td>
   <cfSET   t_S.Skz1_sum  = t_S.Skz1_sum + numberFormat((epr.tr_01),"000")>
   
   
   
  <cfif ListFind(attributes.col_option,3,',') OR not len(attributes.col_option)>  
<!---الضريبة--->
   <!---21--->   <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Deductions Salary Tax">#tlformat((epr.Tax))#</td>  
 <cfset dec_sal_sum= dec_sal_sum + numberFormat(epr.Tax,"000")>
  <cfset GLtax= GLtax + numberFormat(epr.Tax, "000")>													 
</cfif>
<!---سلف--->
<cfif not len(attributes.col_option)>  

   <cfif isdefined('attributes.ADDdetec') AND LEN(attributes.ADDdetec)> 
    <td rowspan="#coloption#"  style="#row_color#; text-align:center"  title="Gross" >#tlformat((epr.advance_inn))# </th> 
	<cfset t_advance_inn= t_advance_inn  + numberFormat((epr.advance_inn),"000")>
   <td rowspan="#coloption#"  style="#row_color#; text-align:center"  title="Gross" > #tlformat((epr.te_aind))# </th>
   <cfset t_te_aind= t_te_aind  + numberFormat((epr.te_aind),"000")>
   </cfif>    
   <td rowspan="#coloption#"  style="#row_color#; text-align:center"  title="Gross" >#tlformat((epr.advance_z))# </td>
<cfset t_advance_sum= t_advance_sum  + numberFormat((epr.advance_z),"000")>

 <!---20 مجموع الاستقطاعات---> <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="holodey">#tlformat(epr.DIS_VACDAY) # </td>   <cfset t_holid_sum= t_holid_sum + NumberFormat(epr.DIS_VACDAY,"000")>



   <!---20 مجموع الاستقطاعات---> <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Deductions">#tlformat(epr.Total_dedect) # </td>   <cfset t_dec_sum= t_dec_sum + NumberFormat(epr.Total_dedect,"000")>


  <!---الراتب التاميني--->
  
 


<!-------------this this ssksalary----------------------------------->
   <!---16---> <td rowspan="#coloption#"  style="#row_color#; text-align:center;background:##DA9694;"  >#tlformat((epr.zz))#  </td> 
    <cfset t_SSk_sum = t_SSk_sum  + numberFormat((epr.zz),"000")>
<!-------------this this ssksalary----------------------------------->
  <!---19--->    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="15%">#tlformat((epr.Health_Insurance_Premium))#</td>
   <cfset t_15_sum = t_15_sum + NumberFormat(epr.Health_Insurance_Premium,"000")>

 
  
 
  
    </cfif>   
  
  
<cfif not len(attributes.col_option)>     
<td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Deductions Salary Tax">#tlformat((epr.Total_others ))#</td>  
 <cfset dec_oth_sum= dec_oth_sum + numberFormat(epr.Total_others ,"000")>
 
 <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Deductions">#tlformat(epr.me2) # </td>   <cfset t_za_sal_sum= t_za_sal_sum + NumberFormat(epr.me2,"000")>
 
<td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Deductions">#tlformat(epr.Net_benefit) # </td>   <cfset t_Net_sum= t_Net_sum + NumberFormat(epr.Net_benefit,"000")>

<cfset GLnet = GLnet + NumberFormat(epr.Net_benefit,"000")>
   <!---23--->  
	
  </cfif>                     
            
<!---</cfloop>--->
 <cfset sub_total_1=0>
 <cfset sub_total_2=0>
 <cfset sub_total_3=0>
 <cfset DAMGA_VERGISI_MATRAH_calc=0>
 <cfset ISSIZLIK_ISVEREN_HISSESI_calc=0>
 <cfif isdefined('attributes.Gross_with_adjust') AND LEN(attributes.Gross_with_adjust)>
                    <cfset _gross=(get_puantaj_rows.DAMGA_VERGISI_MATRAH/MONTH_DAYS*get_puantaj_rows.TOTAL_DAYS)+get_puantaj_rows.TOTAL_PAY_SSK_TAX>
                    <cfelse>
                    <cfset _gross=get_puantaj_rows.DAMGA_VERGISI_MATRAH/MONTH_DAYS*get_puantaj_rows.TOTAL_DAYS>
                    </cfif>
 
 <cfset DAMGA_VERGISI_MATRAH_calc=_gross>
 <cfset ISSIZLIK_ISVEREN_HISSESI_calc=ISSIZLIK_ISVEREN_HISSESI>
                         <cfloop query="GET_ALLOCATION_PROJECT">
                         <cfquery name="GET_ALLOCATION_rate" datasource="#DSN#">
                            SELECT 
                            <cfif attributes.distribution EQ 2 and get_puantaj_rows.func_id eq 2>
                            <cfif FIND('YEM Service',ALLOCATION_NAME)>
                            100 AS RATE
                            <cfelse>
                            0 AS RATE
                            </cfif>
                            <cfelse>
                            isnull(RATE,0) RATE 
                            </cfif>
                            FROM ALLOCATION_PLAN
                            WHERE EMP_ID=#get_puantaj_rows.EMPLOYEE_ID# AND  
                            ALLOCATION_MONTH=#attributes.sal_mon# AND
                            ALLOCATION_YEAR=#attributes.sal_year# AND
                            ALLOCATION_NAME LIKE N'#ALLOCATION_NAME#' AND
                            ALLOCATION_NO LIKE N'#ALLOCATION_NO#'
                          </cfquery>
                           <cfset 'RATE_#currentrow#'=0>
                          <cfif GET_ALLOCATION_rate.recordcount or  len(GET_ALLOCATION_rate.RATE)>
						  <cfset 'RATE_#currentrow#'=GET_ALLOCATION_rate.RATE>
                          </cfif>
                          </cfloop>
                          <cfif attributes.Table eq 2>
                          <cfif ListFind(attributes.Grant_option,1,',')>  
                         <cfloop query="GET_ALLOCATION_PROJECT">
                   <cfset 'M_#currentrow#'=evaluate('M_#currentrow#')+evaluate('RATE_#currentrow#')>
                  <cfset sub_total_3=sub_total_3+evaluate('RATE_#currentrow#')>
                           <td style="border:1px solid ##000;text-align:center" title="#ALLOCATION_NAME#">#evaluate('RATE_#currentrow#')#%</td>
                            </cfloop>
                           <td style="background:<cfif sub_total_3 neq 100>red;<cfelse>##95B3D7;</cfif>border:1px solid ##000;text-align:center" title="TOTAL_RATE%">#tlformat(sub_total_3,0)#%</td> 
                       </cfif>
                       <cfif ListFind(attributes.Grant_option,2,',')>  
                         <cfloop query="GET_ALLOCATION_PROJECT">
                         <cfset 'T_#currentrow#_1'=evaluate('T_#currentrow#_1')+(DAMGA_VERGISI_MATRAH_calc*evaluate('RATE_#currentrow#')/100)>
                         <cfset sub_total_1=sub_total_1+(DAMGA_VERGISI_MATRAH_calc*evaluate('RATE_#currentrow#')/100)>
                         <td style="border:1px solid ##000;text-align:center" title="#ALLOCATION_NAME#">#tlformat(DAMGA_VERGISI_MATRAH_calc*evaluate('RATE_#currentrow#')/100)#</td>
                         </cfloop>
                         <td style="background:##DA9694;border:1px solid ##000;text-align:center" title="TOTAL_SALARY">#tlformat(sub_total_1)#</td>
                     
                         </cfif>
                         <cfif ListFind(attributes.Grant_option,3,',')> 
                         <cfloop query="GET_ALLOCATION_PROJECT">
                   <cfset 'T_#currentrow#_2'=evaluate('T_#currentrow#_2')+(ISSIZLIK_ISVEREN_HISSESI_calc*evaluate('RATE_#currentrow#')/100)>
                  <cfset sub_total_2=sub_total_2+(ISSIZLIK_ISVEREN_HISSESI_calc*evaluate('RATE_#currentrow#')/100)>
                           <td style="border:1px solid ##000;text-align:center" title="#ALLOCATION_NAME#">#tlformat(ISSIZLIK_ISVEREN_HISSESI_calc*evaluate('RATE_#currentrow#')/100)#</td>
                            </cfloop>
                        <td style="background:##D9D9D9;border:1px solid ##000;text-align:center" title="TOTAL_12%">#tlformat(sub_total_2)#</td>
                        </cfif>
                          <cfelse>
						 <cfif ListFind(attributes.Grant_option,1,',')>  
                         <td style="border:1px solid ##000;background:##95B3D7; text-align:center">%</td>
                         <cfloop query="GET_ALLOCATION_PROJECT">
                   <cfset 'M_#currentrow#'=evaluate('M_#currentrow#')+evaluate('RATE_#currentrow#')>
                  <cfset sub_total_3=sub_total_3+evaluate('RATE_#currentrow#')>
                           <td style="border:1px solid ##000;text-align:center" title="#ALLOCATION_NAME#">#evaluate('RATE_#currentrow#')#%</td>
                            </cfloop>
                           <td style="<cfif sub_total_3 neq 100>background:red;</cfif>border:1px solid ##000;text-align:center" title="TOTAL_RATE%">#tlformat(sub_total_3,0)#%</td> 
                       </tr>
                       </cfif>
                       <cfif ListFind(attributes.Grant_option,2,',')>  
                      <cfif attributes.Grant_option eq '1,2,3' or ListFind(attributes.Grant_option,1,',')> <tr id="notsave"></cfif>
                      <td style="background:##DA9694; text-align:center">S</td>
                         <cfloop query="GET_ALLOCATION_PROJECT">
                         <cfset 'T_#currentrow#_1'=evaluate('T_#currentrow#_1')+(DAMGA_VERGISI_MATRAH_calc*evaluate('RATE_#currentrow#')/100)>
                         <cfset sub_total_1=sub_total_1+(DAMGA_VERGISI_MATRAH_calc*evaluate('RATE_#currentrow#')/100)>
                         <td style="border:1px solid ##000;text-align:center" title="#ALLOCATION_NAME#">#tlformat(DAMGA_VERGISI_MATRAH_calc*evaluate('RATE_#currentrow#')/100)#</td>
                         </cfloop>
                         <td style="border:1px solid ##000;text-align:center" title="TOTAL_SALARY">#tlformat(sub_total_1)#</td>
                         </tr>
                         </cfif>
                         <cfif ListFind(attributes.Grant_option,3,',')> 
                         <cfif attributes.Grant_option eq '1,2,3' or ListFind(attributes.Grant_option,1,',') or ListFind(attributes.Grant_option,1,',')> <tr id="notsave"></cfif>
                         <td style="background:##D9D9D9; text-align:center">S.S</td>
                         <cfloop query="GET_ALLOCATION_PROJECT">
                   <cfset 'T_#currentrow#_2'=evaluate('T_#currentrow#_2')+(ISSIZLIK_ISVEREN_HISSESI_calc*evaluate('RATE_#currentrow#')/100)>
                  <cfset sub_total_2=sub_total_2+(ISSIZLIK_ISVEREN_HISSESI_calc*evaluate('RATE_#currentrow#')/100)>
                           <td style="border:1px solid ##000;text-align:center" title="#ALLOCATION_NAME#">#tlformat(ISSIZLIK_ISVEREN_HISSESI_calc*evaluate('RATE_#currentrow#')/100)#</td>
                            </cfloop>
                        <td style="border:1px solid ##000;text-align:center" title="TOTAL_12%">#tlformat(sub_total_2)#</td>
                        </cfif>
                        </cfif>
                         </tr>
                 
                <cfif isdefined("attributes.sort_type") and len(attributes.sort_type) and (currentrow eq recordcount or type is not '#type[get_puantaj_rows.currentrow+1]#')>
                    <cfset cols_plus_ilk = cols_plus>
                    <cfset yillik_izin = d_t_yillik_izin>
                    <cfset cols_plus = cols_plus + 5>

                    <cfset cols_plus = cols_plus_ilk>
                </cfif>
                
            </cfoutput>
            
            <cfset count_ = 0>
            <cfloop list="#odenek_names#" index="cc">
                <cfset count_ = count_ + 1>
                <cfset 'd_t_odenek_#count_#' = 0>
                <cfset 'd_t_odenek_net_#count_#' = 0>
            </cfloop>
            <cfset count_ = 0>
            <cfloop list="#kesinti_names#" index="cc">
                <cfset count_ = count_ + 1>
                <cfset 'd_t_kesinti_#count_#' = 0>
            </cfloop>
            <cfset d_t_avans = 0>
            </cfoutput>
            </cfif>
    </tbody>	 <cfif get_puantaj_rows.recordcount>
    
     
    <cfoutput>
                    <tr height="25" class="total">
                    <cfset row_color="border:1px solid ##000;">
                    <td rowspan="#coloption#"  colspan="<cfif not len(attributes.col_option)>4<cfelse>5</cfif>" style="#row_color#" ><strong>اجمالي</strong></td>
                    <cfif not len(attributes.col_option)>     
                    <td rowspan="#coloption#"  style="#row_color#; text-align:center"  title="TOTAL_BASIC">#tlformat(t_salba_sum)#</td>
                    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="TOTAL_20%">#tlformat(t_Tran_sum)#</td> 
                    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="TOTAL_20%">#tlformat(t_Rep_sum)#</td> 
                     <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="TOTAL_20%">#tlformat(t_Repres_sum)#</td>
                     <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="TOTAL_25%">#tlformat(t_nature_sum1)#</td> 
                    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="TOTAL_allowances">#tlformat(t_Grosss_sum)#</td>
					
					 
	   	  <!-------------------->
  <cfloop query="get_payroll_id">
    <!---<script> alert('<cfoutput>مركز تكلفه#get_allow_costcenter.EXPENSE_id#</cfoutput>');</script>--->
	<!---  <script> alert('<cfoutput>رقم الربط#get_payroll_id.PAYROLL_ID#</cfoutput>');</script>--->
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('gross_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF, budget_item     FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
  SSPADFR.PUANTAJ_ACCOUNT like 'TOTAL_SALARY'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------الراتب الاجمالي------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('gross_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]        
			,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]     
			,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]         
		   ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]         
		   ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF] 
           ,[IS_PAYMENT]            ,[WORKGROUP_ID] 
                       ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'الراتب الاجمالي'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('gross_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#         
		   ,#(val(evaluate('gross_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#      
		   ,0            ,#((val(evaluate('gross_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#      
		   ,#(val((evaluate('gross_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('gross_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#        
		   ,#(val((evaluate('gross_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#        
		   ,0            ,NULL           
		   
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
 
				 
	   	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('SSK9_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF,budget_item  FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
  SSPADFR.PUANTAJ_ACCOUNT like 'NORMAL_KAZANC_'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code -------- حصة الشركة لتأمين الأجتماعي------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('SSK9_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]                     ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'حصة الشركة لتأمين الأجتماعي'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('SSK9_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('SSK9_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('SSK9_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('SSK9_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('SSK9_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('SSK9_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		  
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
				 
	   	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('tr_01_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF,budget_item      FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
   SSPADFR.PUANTAJ_ACCOUNT like 'NORMAL_KAZANC_BRUT_KESINTI_DAHIL'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------  حصة الشركة التدريب------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('tr_01_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'حصة الشركة التدريب'
          ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#,'#ACCDEF.ACC_DEF#'           
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('tr_01_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('tr_01_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('tr_01_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('tr_01_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('tr_01_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('tr_01_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('SSK15c_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF, budget_item    FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
  SSPADFR.PUANTAJ_ACCOUNT like 'NET_UCRET_'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------  صندوق التكافل شركة------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('SSK15c_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES ( 
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'صندوق التكافل شركة'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'           
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('SSK15c_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('SSK15c_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('SSK15c_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('SSK15c_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('SSK15c_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('SSK15c_company_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	 	  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Transportation_allowances_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF,budget_item   FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
   SSPADFR.PUANTAJ_ACCOUNT like 'Transportation_allowances_Incentive'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------  بدل مواصلات------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Transportation_allowances_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'بدل موصلات'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Transportation_allowances_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Transportation_allowances_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Transportation_allowances_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Transportation_allowances_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('Transportation_allowances_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Transportation_allowances_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	  
						  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Call_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF, budget_item      FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
  SSPADFR.PUANTAJ_ACCOUNT like 'Call_allowance_Incentive'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------يدل اتصال --------  -------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Call_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'يدل اتصال'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Call_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Call_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Call_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Call_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('Call_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Call_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	  
						  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Cashier_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF,budget_item  FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
SSPADFR.PUANTAJ_ACCOUNT like 'Cashier_allowance'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!-------- --------   بدل صندوق -----> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Cashier_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'بدل صندوق'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Cashier_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Cashier_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Cashier_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Cashier_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('Cashier_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Cashier_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	   <!---------------------------------------------------------------------------------->
  	 
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Area_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF, budget_item      FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
  SSPADFR.PUANTAJ_ACCOUNT like 'Area_Allowance'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------بدل سكن  --------  -------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Area_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'بدل سكن'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Area_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Area_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Area_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Area_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('Area_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Area_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	  <!----------------------------------------------------------------------------> 
	  	   <!---------------------------------------------------------------------------------->
  	 
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Full_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF, budget_item      FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
  SSPADFR.PUANTAJ_ACCOUNT like 'Full_Allowance'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------بدل محروقات  --------  -------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Full_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'بدل محروقات'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Full_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Full_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Full_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Full_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('Full_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Full_Allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	  <!----------------------------------------------------------------------------> 
						  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Incentive_and_Supervision_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF,budget_item     FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
   SSPADFR.PUANTAJ_ACCOUNT like 'Incentive_and_Supervision_allowance'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------  بدل الحوافز والرقابة ------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Incentive_and_Supervision_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'بدل الحوافز والرقابة'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item_1#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Incentive_and_Supervision_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Incentive_and_Supervision_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Incentive_and_Supervision_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Incentive_and_Supervision_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('Incentive_and_Supervision_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Incentive_and_Supervision_allowance_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	  
						  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Nature_of_work_control_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF,budget_item  FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
   SSPADFR.PUANTAJ_ACCOUNT like 'Nature_of_work_control'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------  طبيعة مراقبة العمل------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Nature_of_work_control_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'طبيعة مراقبة العمل'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Nature_of_work_control_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Nature_of_work_control_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Nature_of_work_control_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Nature_of_work_control_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('Nature_of_work_control_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Nature_of_work_control_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	  
						  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('An_incentive_instead_of_risk_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF,budget_item      FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
 SSPADFR.PUANTAJ_ACCOUNT like 'An_incentive_instead_of_risk'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------  حافز بدلا من المخاطرة ------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('An_incentive_instead_of_risk_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'حافز بدلا من المخاطرة'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('An_incentive_instead_of_risk_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('An_incentive_instead_of_risk_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#(val(evaluate('An_incentive_instead_of_risk_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') )/Gl_Aden_USD)#  
		   ,#(val((evaluate('An_incentive_instead_of_risk_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('An_incentive_instead_of_risk_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('An_incentive_instead_of_risk_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	  
						  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Feed_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF,budget_item    FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
  SSPADFR.PUANTAJ_ACCOUNT like 'Feed_allowance_Incentive'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------   حافز بدل العلف ------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Feed_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'بدل تغذية'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Feed_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Feed_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Feed_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Feed_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#(val(evaluate('Feed_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL'))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Feed_allowance_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	  
						  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Nature_of_work_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF, budget_item     FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
   SSPADFR.PUANTAJ_ACCOUNT like 'Nature_of_work_Incentive'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------  طبيعة العمل الحافز ------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Nature_of_work_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'طبيعة العمل الحافز'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Nature_of_work_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Nature_of_work_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Nature_of_work_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Nature_of_work_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('Nature_of_work_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Nature_of_work_Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  
	  
			<!---			  
	     	  <!-------------------->
  <cfloop query="get_payroll_id">
		                              <cfloop   query = "get_allow_costcenter"  >
	    <cfif evaluate('Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>  
	  		 <cfquery name="ACCDEF" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF,budget_item     FROM SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
   SSPADFR.PUANTAJ_ACCOUNT like 'Incentive'  and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID#    </cfquery>

<!--------yahya code --------   حافز_ ------> 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND evaluate('Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') gt 0>
  <cfquery name="INSERT_Budget_row" datasource="#dsn#" >	
 INSERT INTO [BUDGET_PLAN_ROW]  ( 
            [BUDGET_PLAN_ID]             ,[PLAN_DATE]            ,[DETAIL]            ,[EXP_INC_CENTER_ID]            ,[BUDGET_ITEM_ID]            ,[BUDGET_ACCOUNT_CODE]
            ,[ACTIVITY_TYPE_ID]           ,[RELATED_EMP_ID]        ,[RELATED_EMP_TYPE]  ,[RELATED_ACCOUNT_CODE]        ,ROW_TOTAL_INCOME          ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]            ,ROW_TOTAL_INCOME_2           ,[ROW_TOTAL_EXPENSE_2]             ,[ROW_TOTAL_DIFF_2]            ,[OTHER_ROW_TOTAL_INCOME]            ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]            ,[IS_PAYMENT]            ,[WORKGROUP_ID]            ,[PROJECT_ID]            ,[ACC_TYPE_ID]            ,[ASSETP_ID]   )
	 VALUES (  
	       #MAX_ID.IDENTITYCOL# 	       ,'#dateformat(now(),'yyyy-mm-dd')#'              ,'حافز_'
           ,#get_allow_costcenter.EXPENSE_ID#             ,#ACCDEF.budget_item#		   ,'#ACCDEF.ACC_DEF#'          
		   ,NULL            ,NULL            ,NULL            ,NULL             ,0           
		   ,#(evaluate('Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')/Gl_Aden_USD)#          
		   ,#(val(evaluate('Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') * -1 )/Gl_Aden_USD)#          
		   ,0            ,#((val(evaluate('Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL') ))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#
           ,0            ,#((val(evaluate('Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')))/Gl_Aden_USD)#  
		   ,#(val((evaluate('Incentive_#get_payroll_id.PAYROLL_ID#_#get_allow_costcenter.EXPENSE_id#_TOTAL')) * -1)/Gl_Aden_USD)#            ,0            ,NULL           
		   ,null
         
		   ,NULL            ,NULL)
			</cfquery>
			 </cfif>
			 </cfif>
			 </cfloop>
			 </cfloop>
	  <!-------------------->
	  <!--------------------------------------------------------------------------------------------------->--->
	  
<cfquery name = "dedection_de"  datasource="#dsn#">
	  
SELECT * FROM SETUP_PAYMENT_INTERRUPTION 
 where PAY_ID in (13 ,14 ,15,23, 21,24,25,26)
  </cfquery>
  
 <!---<script> alert('<cfoutput>#dedection_de.COMPANY_ID# </cfoutput>');</script>---->
 
	  	    	<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND dedection_de.COMPANY_ID gt 0 > 

	<cfquery name="ACCDEF2" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF 
     ,ISNULL(budget_item,0) 
  FROM [SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS] SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
   SSPADFR.PUANTAJ_ACCOUNT like 'YILLIK_IZIN_AMOUNT' and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID# 

</cfquery>
		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           ( #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'  صندوق التكافل مساهمة  دقائق التأخير والجزاءات شهر   #attributes.sal_mon# \ #attributes.sal_year#'
           ,4
           ,NULL
           ,'2.3.1.05.5.001'
           ,NULL
		   ,#dedection_de.COMPANY_ID#
           ,'partner'
           ,NULL
           ,#(Ded_gl_total/Gl_Aden_USD)#
           ,0
           ,#(Ded_gl_total/Gl_Aden_USD)#
           ,#(Ded_gl_total/Gl_Aden_USD)#
           ,0
           ,#(Ded_gl_total/Gl_Aden_USD)#
           ,#(Ded_gl_total/Gl_Aden_USD)#
           ,0
           ,#(Ded_gl_total/Gl_Aden_USD)#
           ,0
           ,NULL
           ,null
           ,NULL
           ,NULL)
		   </cfquery>
					   
 </cfif>
 
 	<!-------->
	  <!--------------------------------------------------------------------------------------------------->
	  
<cfquery name = "dedection_de"  datasource="#dsn#">
	  
SELECT * FROM SETUP_PAYMENT_INTERRUPTION 
 where PAY_ID =45
  </cfquery>
  
 <!---<script> alert('<cfoutput>#dedection_de.CONSUMER_ID# </cfoutput>');</script>---->
 
	  	    	<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND dedection_de.CONSUMER_ID gt 0 > 

	<cfquery name="ACCDEF2" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF 
     ,ISNULL(budget_item,0) 
  FROM [SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS] SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
    SSPADFR.PUANTAJ_ACCOUNT='SAKATLIK_INDIRIMI' and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID# 

</cfquery>
		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           ( #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'  أستقطاع ون فملي One-fimaly  #attributes.sal_mon# \ #attributes.sal_year#'
           ,4
           ,NULL
           ,'2.3.1.05.5.009'
           ,NULL
		   ,#dedection_de.CONSUMER_ID#
           ,'CONSUMER'
           ,NULL
           ,#(One_fimailys_t/Gl_Aden_USD)#
           ,0
           ,#(One_fimailys_t/Gl_Aden_USD)#
           ,#(One_fimailys_t/Gl_Aden_USD)#
           ,0
           ,#(One_fimailys_t/Gl_Aden_USD)#
           ,#(One_fimailys_t/Gl_Aden_USD)#
           ,0
           ,#(One_fimailys_t/Gl_Aden_USD)#
           ,0
           ,NULL
           ,null
           ,NULL
           ,NULL)
		   </cfquery>
					   
 </cfif>
 
 	<!-------->



<cfquery name = "dedection_de_re"  datasource="#dsn#">
	  
SELECT * FROM SETUP_PAYMENT_INTERRUPTION 
 where PAY_ID = 21
  </cfquery>

 <!---<script> alert('<cfoutput>#dedection_de_re.CONSUMER_ID# </cfoutput>');</script>---->
 
	  	    	<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND dedection_de_re.CONSUMER_ID gt 0 > 

	<cfquery name="ACCDEF2" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF 
     ,ISNULL(budget_item,0) 
  FROM [SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS] SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
   SSPADFR.PUANTAJ_ACCOUNT like 'GELIR_VERGISI_INDIRIMI_5746' and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID# 

</cfquery>
  <cfif  ACCDEF2.recordcount   > 
		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           ( #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'  قسط مطعم   #attributes.sal_mon##attributes.sal_year#'
           ,null
           ,NULL
           ,'1.2.8.06.2.005'
           ,NULL
		   ,#dedection_de_re.CONSUMER_ID#
           ,'consumer'
           ,NULL
           ,#(t_Dedec_gl7/Gl_Aden_USD)#
           ,0
           ,#(t_Dedec_gl7/Gl_Aden_USD)#
           ,#(t_Dedec_gl7/Gl_Aden_USD)#
           ,0
           ,#(t_Dedec_gl7/Gl_Aden_USD)#
           ,#(t_Dedec_gl7/Gl_Aden_USD)#
           ,0
           ,#(t_Dedec_gl7/Gl_Aden_USD)#
           ,0
           ,NULL
           ,null
           ,NULL
           ,NULL)
		   </cfquery>
					   
 </cfif>
 
 						   
 </cfif>
 <!-------- حصة الموظف بصندوف التكافل زالشركه------------>
	  
<cfquery name = "dedection_de_CA"  datasource="#dsn#">
	  
SELECT * FROM SETUP_PAYMENT_INTERRUPTION 
 where PAY_ID =44
  </cfquery>
  
 
 <!----<script> alert('<cfoutput>#dedection_de_CA.COMPANY_ID# </cfoutput>');</script>---->
	  	    	<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND dedection_de_CA.COMPANY_ID gt 0 > 

	<cfquery name="ACCDEF2" datasource="#dsn#">
	
SELECT ACCOUNT_CODE  ACC_DEF 
     ,ISNULL(budget_item,0) 
  FROM [SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF_ROWS] SSPADFR  inner join [wrk_rgyemen].[wrk_rgyemen].SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF SSPADF
  on SSPADF.OUR_COMPANY_ID = #session.ep.company_id# and 
   SSPADFR.PUANTAJ_ACCOUNT like 'YILLIK_IZIN_AMOUNT' and SSPADFR.PAYROLL_ID=   #get_payroll_id.PAYROLL_ID# 

</cfquery>
		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           ( #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'  صندوق  التكافل مساهمة  الشركة والموظف شهر  #attributes.sal_mon##attributes.sal_year#'
           ,4
           ,NULL
           ,'2.3.1.05.5.001'
           ,NULL
		   ,#dedection_de_CA.COMPANY_ID#
           ,'partner'
           ,NULL
           ,#(t_Dedec_gl9/Gl_Aden_USD)#
           ,0
           ,#(t_Dedec_gl9/Gl_Aden_USD)#
           ,#(t_Dedec_gl9/Gl_Aden_USD)#
           ,0
           ,#(t_Dedec_gl9/Gl_Aden_USD)#
           ,#(t_Dedec_gl9/Gl_Aden_USD)#
           ,0
           ,#(t_Dedec_gl9/Gl_Aden_USD)#
           ,0
           ,NULL
           ,null
           ,NULL
           ,NULL)
		   </cfquery>
					   
 </cfif>
 		
		  
<cfquery name = "dedection_Sal"  datasource="#dsn#">
	  
SELECT * FROM SETUP_PAYMENT_INTERRUPTION 
 where PAY_ID =41
  </cfquery>
  
<!---<script> alert('<cfoutput>#dedection_Sal.CONSUMER_ID# </cfoutput>');</script>--->
	  	    	<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND dedection_Sal.CONSUMER_ID gt 0 > 

		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           ( #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'اثبات ضريبة مرتبات شهر  #attributes.sal_mon# / #attributes.sal_year#'
           ,NULL
           ,NULL
           ,'2.3.1.05.4.002'
           ,NULL
		   ,#dedection_Sal.CONSUMER_ID#
           ,'consumer'
           ,NULL
           ,#(GLtax/Gl_Aden_USD)#
           ,0
           ,#(GLtax/Gl_Aden_USD)#
           ,#(GLtax/Gl_Aden_USD)#
           ,0
           ,#(GLtax/Gl_Aden_USD)#
           ,#(GLtax/Gl_Aden_USD)#
           ,0
           ,#(GLtax/Gl_Aden_USD)#
           ,0
           ,NULL
           ,null
           ,NULL
           ,NULL)
		   </cfquery> 
	</cfif>
	  
<cfquery name = "dedection_Sal"  datasource="#dsn#">
	  
SELECT * FROM SETUP_PAYMENT_INTERRUPTION 
 where PAY_ID =40
  </cfquery>
  
  
 <!---<script> alert('<cfoutput>#dedection_Sal.CONSUMER_ID# </cfoutput>');</script>--->
	  	    	<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND dedection_Sal.CONSUMER_ID gt 0 > 	
<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES(
           #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'اثبات استحقاق مرتبات الموظفين لشهر  #attributes.sal_mon# / #attributes.sal_year#'
           ,NULL
           ,NULL
           ,'2.3.1.05.2.001'
           ,NULL
		   ,#dedection_Sal.CONSUMER_ID#
           ,'consumer'
           ,NULL
           ,#(GLnet/Gl_Aden_USD)#
           ,0
           ,#(GLnet/Gl_Aden_USD)#
           ,#(GLnet/Gl_Aden_USD)#
           ,0
           ,#(GLnet/Gl_Aden_USD)#
           ,#(GLnet/Gl_Aden_USD)#
           ,0
           ,#(GLnet/Gl_Aden_USD)#
           ,0
           ,NULL
           ,null
           ,NULL
           ,NULL)
		   </cfquery>	
		   </cfif>
			      <!---المؤسسة العامة للتامينات الاجتماعية--->
				  
				  <cfquery name = "dedection_Insur"  datasource="#dsn#">
	  
SELECT * FROM SETUP_PAYMENT_INTERRUPTION 
 where PAY_ID =42
  </cfquery>
				<!---  <script> alert('<cfoutput>#dedection_Insur.COMPANY_ID# </cfoutput>');</script>--->
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND dedection_Insur.COMPANY_ID gt 0 > 
		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           ( #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'اثبات استحقاق تامينات اجتماعية لشهر  #attributes.sal_mon# / #attributes.sal_year#'
           ,NULL
           ,NULL
           ,'2.3.1.05.4.001'
           ,NULL
		   ,#dedection_Insur.COMPANY_ID# 
           ,'partner'
           ,NULL
           ,#(GLins/Gl_Aden_USD)#
           ,0
           ,#(GLins/Gl_Aden_USD)#
           ,#(GLins/Gl_Aden_USD)#
           ,0
           ,#(GLins/Gl_Aden_USD)#
           ,#(GLins/Gl_Aden_USD)#
           ,0
           ,#(GLins/Gl_Aden_USD)#
           ,0
           ,NULL
           ,null
           ,NULL
           ,NULL)
		   </cfquery> 		   
 </cfif>	
 	  
<cfquery name = "dedection_Sal"  datasource="#dsn#">
	  
SELECT * FROM SETUP_PAYMENT_INTERRUPTION 
 where PAY_ID =43
  </cfquery>
  
  <!---<script> alert('<cfoutput>#dedection_Sal.CONSUMER_ID# </cfoutput>');</script>--->
	  	    	<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL) AND dedection_Sal.CONSUMER_ID gt 0 > 

		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           ( #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'صنــدوق التدريب #attributes.sal_mon# / #attributes.sal_year#'
           ,NULL
           ,NULL
           ,'2.3.1.05.4.005'
           ,NULL
		   ,#dedection_Sal.CONSUMER_ID#
           ,'consumer'
           ,NULL
           ,#(t_Dedec_gl11/Gl_Aden_USD)#
           ,0
           ,#(t_Dedec_gl11/Gl_Aden_USD)#
           ,#(t_Dedec_gl11/Gl_Aden_USD)#
           ,0
           ,#(t_Dedec_gl11/Gl_Aden_USD)#
           ,#(t_Dedec_gl11/Gl_Aden_USD)#
           ,0
           ,#(t_Dedec_gl11/Gl_Aden_USD)#
           ,0
           ,NULL
           ,null
           ,NULL
           ,NULL)
		   </cfquery> 
</cfif>

				
	  			
		      <cfquery name="GET_SAL_GET" datasource="#DSN#">
                       SELECT   * FROM [wrk_rgyemen].[wrk_rgyemen].[SALARYPARAM_GET]
						 
                            WHERE  
                           (END_SAL_MON=#attributes.sal_mon# OR #attributes.sal_mon# BETWEEN START_SAL_MON AND END_SAL_MON)
                           AND
                            TERM=#attributes.sal_year#  AND 
							Employee_id in (#VALUELIST(get_puantaj_rows.employee_id)#)
							
				AND COMMENT_GET in ('سلفة مؤقتة','Avans','Temporary_Advance','Health_Insurance_premium' )
				
				AND AMOUNT_GET <> 0

					 </cfquery>
					 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL)>					 
					  
					
		 <cfloop query="GET_SAL_GET">

	<cfscript>
		get_puantaj_1 = createObject("component", "v16.hr.ehesap.cfc.Ytech_Putan");
	
		
		epr = get_puantaj_1.emp_pun1
		(
			sal_year : attributes.sal_year,
			sal_mon : attributes.sal_mon,
			employee_id :#GET_SAL_GET.EMPLOYEE_ID#
			
		);
	</cfscript>


		      <!---تامي--->
		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           (  #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'استقطاع السلفة المؤقتة لراتب شهر_#attributes.sal_mon#_#attributes.sal_year#'
           ,NULL
           ,NULL
          , '1.2.8.01.1.002' 
            ,NULL
		   ,#GET_SAL_GET.EMPLOYEE_ID#
           ,'employee'
           ,NULL 
           ,#((GET_SAL_GET.AMOUNT_GET )/Gl_Aden_USD) #
           ,0
           ,#((GET_SAL_GET.AMOUNT_GET)/Gl_Aden_USD) #
           ,#((GET_SAL_GET.AMOUNT_GET)/Gl_Aden_USD)#
           ,0
           ,#((GET_SAL_GET.AMOUNT_GET)/Gl_Aden_USD) #
           ,#((GET_SAL_GET.AMOUNT_GET)/Gl_Aden_USD) #
           ,0
           ,#((GET_SAL_GET.AMOUNT_GET )/Gl_Aden_USD) #
           ,0
           ,NULL
           ,null
          , -2 
           ,NULL)
		   </cfquery> 
		   


      </cfloop>	
					 
	  </cfif>

<!------------------->

<cfquery name="GET_SAL_GET2" datasource="#DSN#">
                       SELECT   * FROM [wrk_rgyemen].[wrk_rgyemen].[SALARYPARAM_GET]
						 
                            WHERE  
                           (END_SAL_MON=#attributes.sal_mon# OR #attributes.sal_mon# BETWEEN START_SAL_MON AND END_SAL_MON)
                           AND
                            TERM=#attributes.sal_year#  AND 
							Employee_id in (#VALUELIST(get_puantaj_rows.employee_id)#)
							
				AND COMMENT_GET in ('Purchase_Deductions')
				AND AMOUNT_GET <> 0

					 </cfquery>
					 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL)>					 
					  
					
		 <cfloop query="GET_SAL_GET2">

	<cfscript>
		get_puantaj_1 = createObject("component", "v16.hr.ehesap.cfc.Ytech_Putan");
	
		
		epr = get_puantaj_1.emp_pun1
		(
			sal_year : attributes.sal_year,
			sal_mon : attributes.sal_mon,
			employee_id :#GET_SAL_GET2.EMPLOYEE_ID#
			
		);
	</cfscript>


		      <!---Purchase_ded--->
		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           (  #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'استقطاع مشتريات موظفين من راتب_#attributes.sal_mon#_#attributes.sal_year#'
           ,NULL
           ,NULL
          , '1.2.8.01.1.001' 
            ,NULL
		   ,#GET_SAL_GET2.EMPLOYEE_ID#
           ,'employee'
           ,NULL 
           ,#((GET_SAL_GET2.AMOUNT_GET )/Gl_Aden_USD) #
           ,0
           ,#((GET_SAL_GET2.AMOUNT_GET)/Gl_Aden_USD) #
           ,#((GET_SAL_GET2.AMOUNT_GET)/Gl_Aden_USD)#
           ,0
           ,#((GET_SAL_GET2.AMOUNT_GET) /Gl_Aden_USD)#
           ,#((GET_SAL_GET2.AMOUNT_GET) /Gl_Aden_USD) #
           ,0
           ,#((GET_SAL_GET2.AMOUNT_GET ) /Gl_Aden_USD)#
           ,0
           ,NULL
           ,null
          , 1031 
           ,NULL)
		   </cfquery> 
		   


      </cfloop>	
					 
	  </cfif>				 

<!------------------->	  
				
		
	  			
		      <cfquery name="GET_SAL_GET1" datasource="#DSN#">
                         select *   FROM [SALARYPARAM_GET]
						 
                            WHERE  
                           (END_SAL_MON=#attributes.sal_mon# OR #attributes.sal_mon# BETWEEN START_SAL_MON AND END_SAL_MON)
                            AND
                            TERM=#attributes.sal_year#  AND 
							Employee_id in (#VALUELIST(get_puantaj_rows.employee_id)#)
							 and COMMENT_GET in ('Advances' , 'سلف مستديمة')
							 AND AMOUNT_GET <> 0
							
	
					 </cfquery>
					 
<cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL)>					 
					  
					
		 <cfloop query="GET_SAL_GET1">

	<cfscript>
		get_puantaj_1 = createObject("component", "v16.hr.ehesap.cfc.Ytech_Putan");
	
		
		epr = get_puantaj_1.emp_pun1
		(
			sal_year : attributes.sal_year,
			sal_mon : attributes.sal_mon,
			employee_id :#GET_SAL_GET1.EMPLOYEE_ID#
			
		);
	</cfscript>


		      <!---تامي--->
		<cfquery name="INSERT_Budget_Row" datasource="#dsn#">
			INSERT INTO [BUDGET_PLAN_ROW]
           ([BUDGET_PLAN_ID] 
           ,[PLAN_DATE]
           ,[DETAIL]
           ,[EXP_INC_CENTER_ID]
           ,[BUDGET_ITEM_ID]
           ,[BUDGET_ACCOUNT_CODE]
           ,[ACTIVITY_TYPE_ID]
           ,[RELATED_EMP_ID]
           ,[RELATED_EMP_TYPE]
           ,[RELATED_ACCOUNT_CODE]
           ,[ROW_TOTAL_INCOME]
           ,[ROW_TOTAL_EXPENSE]
           ,[ROW_TOTAL_DIFF]
           ,[ROW_TOTAL_INCOME_2]
           ,[ROW_TOTAL_EXPENSE_2]
           ,[ROW_TOTAL_DIFF_2]
           ,[OTHER_ROW_TOTAL_INCOME]
           ,[OTHER_ROW_TOTAL_EXPENSE]
           ,[OTHER_ROW_TOTAL_DIFF]
           ,[IS_PAYMENT]
           ,[WORKGROUP_ID]
           ,[PROJECT_ID]
           ,[ACC_TYPE_ID]
           ,[ASSETP_ID])
     VALUES
           (  #MAX_ID.IDENTITYCOL#
	       ,'#dateformat(now(),'yyyy-mm-dd')#'
           ,'استقطاع السلفة المستديمة من راتب شهر_#attributes.sal_mon#_#attributes.sal_year#'
           ,NULL
           ,NULL
          , '1.2.8.01.1.001' 
            ,NULL
		   ,#GET_SAL_GET1.EMPLOYEE_ID#
           ,'employee'
           ,NULL 
           ,#((GET_SAL_GET1.AMOUNT_GET) /Gl_Aden_USD)#
           ,0
           ,#((GET_SAL_GET1.AMOUNT_GET)/Gl_Aden_USD) #
           ,#((GET_SAL_GET1.AMOUNT_GET)/Gl_Aden_USD)#
           ,0
           ,#((GET_SAL_GET1.AMOUNT_GET )/Gl_Aden_USD) #
           ,#((GET_SAL_GET1.AMOUNT_GET  )/Gl_Aden_USD) #
           ,0
           ,#((GET_SAL_GET1.AMOUNT_GET )/Gl_Aden_USD) #
           ,0
           ,NULL
           ,null
          , -3 
           ,NULL)
		   </cfquery> 
		   


      </cfloop>	
					 
	  </cfif>				 
									
					
					
					
                    </cfif>
                    
                     <cfif ListFind(attributes.col_option,2,',') OR not len(attributes.col_option)> 
                              
   <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_9%">#tlformat(t_S.S9_sum)#</td>
                    </cfif>
                    
                <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_GROSS">#tlformat(total_z)#</td>
                <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_6%">#tlformat(t_Satax_sum)#</td>  
                    <cfif ListFind(attributes.col_option,1,',') OR not len(attributes.col_option)> 
                    <td rowspan="#coloption#" style="#row_color#;background:##D9D9D9; text-align:center" title="TOTAL_6%">#tlformat(t_S.S6_sum)#</td>
                    </cfif>
					 <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_6%">#tlformat(t_SSK011_sum)#</td>
              <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_6%">#tlformat(t_SSK01_sum)#</td>
                   <td rowspan="#coloption#" style="#row_color#; text-align:center" >#tlformat(t_S.Skz1_sum)#</td>
                    <cfif not len(attributes.col_option) >     
                 
                  <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_Deductions Taxable">#tlformat(dec_sal_sum)#</td> 
                     
					  <cfif isdefined('attributes.ADDdetec') AND LEN(attributes.ADDdetec)> 
     <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_6%">#tlformat(t_advance_inn)#</td>
				   <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_6%">#tlformat(t_te_aind)#</td>
   </cfif>    
					 
				 
            <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_6%">#tlformat(t_advance_sum)#</td>
            <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_6%">#tlformat( t_holid_sum)#</td>
              <td rowspan="#coloption#" style="#row_color#; text-align:center" title="18%">#tlformat(t_dec_sum)#</td>       
              
<td rowspan="#coloption#" style="#row_color#;background:##DA9694;  text-align:center" title="TOTAL_GROSS S.S">#tlformat(t_SSk_sum)#</td> 
					
                    <td rowspan="#coloption# "style="#row_color#;text-align:center" title="TOTAL_GROSS BASE ON DAYS">#tlformat(t_15_sum)#</td>
                  
                   
                    </cfif>
                    <cfif ListFind(attributes.col_option,3,',')OR not len(attributes.col_option)> 
                    <td rowspan="#coloption#" style="#row_color#; text-align:center" title="TOTAL_Deductions Salary Tax">#tlformat(dec_oth_sum)#</td>
                    </cfif>
                    <td rowspan="#coloption#" style="#row_color#; text-align:center" >#tlformat(t_za_sal_sum)#</td>
                    <!---<td><div align="left">#Dedection1#</div></td>--->
                    <cfif not len(attributes.col_option)>    
         <!----           
              <cfif isdefined('attributes.ADDGL') AND LEN(attributes.ADDGL)>      <td  hidden rowspan="#coloption#" style="#row_color#;<cfif isdefined('attributes.Gross_with_adjust') AND LEN(attributes.Gross_with_adjust)>background:##DA9694;</cfif> text-align:center" title="Total Adjustment">#tlformat(t_salba_sum)#</td>
</cfif>
		----->			
                    <td rowspan="#coloption#" style="#row_color#; text-align:center">#tlformat(t_Net_sum)#</td>
					 
						
             
					
                   </cfif>
                    <cfset t1=0>
                    <cfset t2=0>
                    <cfset t3=0>
                      <cfif attributes.Table eq 2>
                      <cfif ListFind(attributes.Grant_option,1,',')>  
                    <cfloop query="GET_ALLOCATION_PROJECT">
                        <td style="#row_color#;text-align:center" title="TOTAL_#ALLOCATION_NAME#">#tlformat(evaluate('M_#currentrow#'),0)#%</td>
                        <cfset t3=t3+evaluate('M_#currentrow#')>
                       </cfloop>
                       <td style="#row_color#;text-align:center">#tlformat(t3,0)#%</td>
                       
                       </cfif>
                       <cfif ListFind(attributes.Grant_option,2,',')>  
                       
                      <cfloop query="GET_ALLOCATION_PROJECT">
                        <td style="#row_color# text-align:center" title="TOTAL_#ALLOCATION_NAME#">#tlformat(evaluate('T_#currentrow#_1'))#</td>
                        <cfset t1=t1+evaluate('T_#currentrow#_1')>
                       </cfloop>
                       <td style="text-align:center;#row_color# background:##D9D9D9;">#tlformat(t1)#</td>
                  
                     </cfif>
                     <cfif ListFind(attributes.Grant_option,3,',')>  
                   
                      <cfloop query="GET_ALLOCATION_PROJE  CT">
                        <td style="#row_color# text-align:center" title="TOTAL_#ALLOCATION_NAME#">#tlformat(evaluate('T_#currentrow#_2'))#</td>
                         <cfset t2=t2+evaluate('T_#currentrow#_2')>
                       </cfloop>
                       <td style="#row_color# background:##D9D9D9; text-align:center">#tlformat(t2)#</td>
                       </cfif>
                      <cfelse>
					  <cfif ListFind(attributes.Grant_option,1,',')>  
                    <td style="border:1px solid ##000;background:##95B3D7;text-align:center">%</td>
                    <cfloop query="GET_ALLOCATION_PROJECT">
                        <td style="#row_color#;text-align:center" title="TOTAL_#ALLOCATION_NAME#">#tlformat(evaluate('M_#currentrow#'),0)#%</td>
                        <cfset t3=t3+evaluate('M_#currentrow#')>
                       </cfloop>
                       <td style="#row_color#;text-align:center">#tlformat(t3,0)#%</td>
                       
                       </tr>
                       </cfif>
                       <cfif ListFind(attributes.Grant_option,2,',')>  
                       <cfif attributes.Grant_option eq '1,2,3' or ListFind(attributes.Grant_option,1,',')> <tr id="notsave"></cfif>
                       <td style="background:##DA9694;#row_color# text-align:center">S</td>
                      <cfloop query="GET_ALLOCATION_PROJECT">
                        <td style="#row_color# text-align:center" title="TOTAL_#ALLOCATION_NAME#">#tlformat(evaluate('T_#currentrow#_1'))#</td>
                        <cfset t1=t1+evaluate('T_#currentrow#_1')>
                       </cfloop>
                       <td style="text-align:center;#row_color#">#tlformat(t1)#</td>
                     </tr>
                     </cfif>
                     <cfif ListFind(attributes.Grant_option,3,',')>  
                     <cfif attributes.Grant_option eq '1,2,3' or ListFind(attributes.Grant_option,1,',') or ListFind(attributes.Grant_option,1,',')> <tr id="notsave"></cfif>
                     <td style="background:##D9D9D9;#row_color# text-align:center">S.S</td>
                      <cfloop query="GET_ALLOCATION_PROJECT">
                        <td style="#row_color# text-align:center" title="TOTAL_#ALLOCATION_NAME#">#tlformat(evaluate('T_#currentrow#_2'))#</td>
                         <cfset t2=t2+evaluate('T_#currentrow#_2')>
                       </cfloop>
                       <td style="#row_color# text-align:center">#tlformat(t2)#</td>
                       </cfif>
                      </cfif>
                    
                    </tr>
                    
                    <cfif Get_signs.RECORDCOUNT OR Get_REVIEW.RECORDCOUNT>
                    <cfset REC_EMP=-1>
					<cfSET REC_POS='Finance Manager'>
                    <cfset REC_DATE=''>
                    <cfset SR_ID=''>
                    <cfset HR_REC_EMP=-1>
                    <cfSET HR_REC_POS='HR & Admin Manager'>
                    <cfset HR_REC_DATE=''>
                    <cfif Get_signs.RECORDCOUNT>
                    <cfset SR_ID=Get_signs.SR_ID>
                    <cfSET REC_POS=Get_signs.POSITION_NAME1>
                    <cfSET HR_REC_POS=Get_signs.HR_POSITION_NAME>
					<cfset REC_EMP=Get_signs.RECORD_EMP>
                    
                    <cfif NOT FIND('Finance',Get_signs.POSITION_NAME1) OR NOT FIND('Manager',Get_signs.POSITION_NAME1)>
					<cfSET REC_POS='Acting Finance Manager'>
                    </cfif>
                     <cfset REC_DATE=Get_signs.RECORD_DATE>
                    <cfset HR_REC_EMP=Get_signs.HR_ID>
                    
                    <cfif NOT FIND('HR',Get_signs.HR_POSITION_NAME) OR NOT FIND('Manager',Get_signs.HR_POSITION_NAME)>
					<cfSET HR_REC_POS='Acting HR & Admin Manager'>
                    </cfif>
                    
                    <cfset HR_REC_DATE=Get_signs.HR_DATE>
                    <cfelse>
                    <cfset SR_ID=Get_REVIEW.SR_ID>
                    <cfSET REC_POS=Get_REVIEW.POSITION_NAME1>
                    <cfSET HR_REC_POS=Get_REVIEW.HR_POSITION_NAME>
                    <cfset REC_EMP=Get_REVIEW.RECORD_EMP>
                    <cfif NOT FIND('Finance',Get_REVIEW.POSITION_NAME1) OR NOT FIND('Manager',Get_REVIEW.POSITION_NAME1)>
					<cfSET REC_POS='Acting Finance Manager'>
                    </cfif>
                     <cfset REC_DATE=Get_REVIEW.RECORD_DATE>
                    <cfset HR_REC_EMP=Get_REVIEW.HR_ID>
                    <cfif NOT FIND('HR',Get_REVIEW.HR_POSITION_NAME) OR NOT FIND('Manager',Get_REVIEW.HR_POSITION_NAME)>
					<cfSET HR_REC_POS='Acting HR & Admin Manager'>
                    </cfif>
                    <cfset HR_REC_DATE=Get_REVIEW.HR_DATE>
                    </cfif>
                    <tr id="sign">
                    <cfif len(attributes.col_option)>
                     <cfif attributes.Table eq 2>
                      <td colspan="#(GET_ALLOCATION_PROJECT.recordcount*LISTlen(attributes.col_option))+10+LISTlen(attributes.col_option)#"></td>
                     <cfelse>
                    <td colspan="#GET_ALLOCATION_PROJECT.recordcount+10+LISTlen(attributes.col_option)#"></td>
                    </cfif>
                    <cfelse>
                    <cfif attributes.Table eq 2><td colspan="#(GET_ALLOCATION_PROJECT.recordcount)+30#">
                    <cfelse><td colspan="#GET_ALLOCATION_PROJECT.recordcount+27#"></cfif>
                    </cfif>
                    <table style="width:100%" align="Right" dir="rtl">
                    <tr>
                    <cfset column_total='text-align:center; font-size:12px; width:15%'>
                      <td style="#column_total#"><cfscript>getimpdata(1,HR_REC_EMP);</cfscript>Prepared BY<BR />#get_emp_info(HR_REC_EMP,0,0)#<BR  />#HR_REC_POS#<br /><br />#dateformat(HR_REC_DATE, 'dd-mmm-yyyy ')##TimeFormat(HR_REC_DATE,"HH:mm")#
                      </td>
                     <td style="#column_total#"><cfscript>getimpdata(1,REC_EMP);</cfscript>Reviewed BY<BR />#get_emp_info(REC_EMP,0,0)#<BR  />#REC_POS#<br /><br />#dateformat(REC_DATE, 'dd-mmm-yyyy ')##TimeFormat(REC_DATE,"HH:mm")#
                      </td>
                     
                      <cfif not len(Get_REVIEW.WARNING_RESULT)>
                        <td style="#column_total#">
                        <font color="RED"> NOT Reviewed YET<br />#get_emp_info(Get_REVIEW.POSITION_CODE,1,0)#<br /><cfif NOT FIND('Compliance',Get_REVIEW.POSITION_NAME) OR NOT FIND('Manager',Get_REVIEW.POSITION_NAME)>Acting Compliance Manager<cfelse>#Get_REVIEW.POSITION_NAME#</cfif></font><br /><br />
                        <a href="javascript://" onclick="windowopen('#request.self#?fuseaction=report.detail_report&report_id=#attributes.report_id#&resend_email&POSITION_CODE=#Get_REVIEW.POSITION_CODE#&SR_ID=#Get_REVIEW.SR_ID#&W_ID_=#Get_REVIEW.W_ID#&REPORT_NAME=KOA_#attributes.sal_mon#_#attributes.sal_year#&type=-1','small');"><font color="blue"><strong>Resend an E-mail</strong></font></a><br />
                        last sent on #dateformat(Get_REVIEW.EMAIL_WARNING_DATE, 'dd-mmm-yyyy')# #TimeFormat(Get_REVIEW.EMAIL_WARNING_DATE,"HH:mm")#<br />
                        <cfif (len(REVIEWER1_code) and REVIEWER1_code eq Get_REVIEW.POSITION_CODE) or not len(REVIEWER1_code)>
                            to change the reviewer please choose the Reviewer employee from above and click search then use the link here
                        <cfelseif len(REVIEWER1_code) and REVIEWER1_code neq Get_REVIEW.POSITION_CODE>
                             <a href="javascript://" onclick="windowopen('#request.self#?fuseaction=report.detail_report&report_id=#attributes.report_id#&resend_email&POSITION_CODE=#REVIEWER1_code#&SR_ID=#SR_ID#&W_ID_2=#Get_REVIEW.W_ID#&REPORT_NAME=KOA_#attributes.sal_mon#_#attributes.sal_year#&type=-1','small');"><font color="blue"><strong>change the reviwer and send an e-mail to #get_emp_info(attributes.REVIEWER1_id,0,0)#</strong></font></a><br />
                        </cfif>
                        </td>
                        <cfelseif find('Rejec',Get_REVIEW.WARNING_RESULT)>
                        <td style="#column_total#">
                        <font color="RED"> Rejected BY<br />#get_emp_info(Get_REVIEW.POSITION_CODE,1,0)#<br /><cfif NOT FIND('Compliance',Get_REVIEW.POSITION_NAME) OR NOT FIND('Manager',Get_REVIEW.POSITION_NAME)>Acting Compliance Manager<cfelse>#Get_REVIEW.POSITION_NAME#</cfif></font></td>
                        <cfelseif find('Appro',Get_REVIEW.WARNING_RESULT)>
                        <td style="text-align:center; font-size:12px">
						<cfscript>getimpdata(2,Get_REVIEW.POSITION_CODE);</cfscript>
                        Verified By<br />#get_emp_info(Get_REVIEW.POSITION_CODE,1,0)#<br /><cfif NOT FIND('Compliance',Get_REVIEW.POSITION_NAME) OR NOT FIND('Manager',Get_REVIEW.POSITION_NAME)>Acting Compliance Manager<cfelse>#Get_REVIEW.POSITION_NAME#</cfif><br /><br />#dateformat(Get_REVIEW.APPROVE_DATE, 'dd-mmm-yyyy ')##TimeFormat(Get_REVIEW.APPROVE_DATE,"HH:mm")#</td>
                        </cfif>
                       <td style="text-align:center; font-size:12px; width:25%"></td>
                       
                       <cfloop query="Get_signs">
					   <cfset sign_possition=Get_signs.POSITION_NAME>
                       
                       <cfif currentrow eq 1>
                       
                       <cfif NOT FIND('Finance',Get_signs.POSITION_NAME) OR NOT FIND('Director',Get_signs.POSITION_NAME)>
                       <cfset sign_possition='Acting Finance Administrative Director'>
                       </cfif>
                       
                       <cfelse>
                       
                       <cfif NOT FIND('Country',Get_signs.POSITION_NAME) OR NOT FIND('Director',Get_signs.POSITION_NAME)>
                       <cfset sign_possition='Acting Country Director'>
                       </cfif>
                       
                       </cfif>
                       
                        <cfif not len(Get_signs.WARNING_RESULT)>
                        <td style="#column_total#">
                        <font color="RED"> NOT APPROVED YET<br />#get_emp_info(Get_signs.POSITION_CODE,1,0)#<br />#sign_possition#</font><br /><br />
                        
                        <a href="javascript://" onclick="windowopen('#request.self#?fuseaction=report.detail_report&report_id=#attributes.report_id#&resend_email&POSITION_CODE=#Get_signsPOSITION_CODE#&SR_ID=#SR_ID#&W_ID_=#Get_signs.W_ID#&REPORT_NAME=KOA_#attributes.sal_mon#_#attributes.sal_year#&type=#Get_signs.SETUP_WARNING_ID#','small');"><font color="blue"><strong>Resend an E-mail</strong></font></a></a><br />
                        last sent on #dateformat(Get_signs.EMAIL_WARNING_DATE, 'dd-mmm-yyyy')# #TimeFormat(Get_signs.EMAIL_WARNING_DATE,"HH:mm")#<br />
                        <cfif currentrow eq 1>
                        <cfif (len(APPROVAL1_code) and APPROVAL1_code eq Get_signs.POSITION_CODE) or not len(APPROVAL1_code)>
                            to change the Approval FAD please choose the Approval FAD employee from above and click search then use the link here
                        <cfelseif len(APPROVAL1_code) and APPROVAL1_code neq Get_signs.POSITION_CODE>
                             <a href="javascript://" onclick="windowopen('#request.self#?fuseaction=report.detail_report&report_id=#attributes.report_id#&resend_email&POSITION_CODE=#APPROVAL1_code#&SR_ID=#SR_ID#&W_ID_2=#Get_signs.W_ID#&REPORT_NAME=KOA_#attributes.sal_mon#_#attributes.sal_year#&type=-3','small');"><font color="blue"><strong>change the reviwer and send an e-mail to #get_emp_info(attributes.APPROVAL1_id,0,0)#</strong></font></a><br />
                        </cfif>
                        <cfelse>
                          <cfif (len(APPROVAL2_code) and APPROVAL2_code eq Get_signs.POSITION_CODE) or not len(APPROVAL2_code)>
                            to change the Approval CD please choose the Approval CD employee from above and click search then use the link here
                        <cfelseif len(APPROVAL2_code) and APPROVAL2_code neq Get_signs.POSITION_CODE>
                             <a href="javascript://" onclick="windowopen('#request.self#?fuseaction=report.detail_report&report_id=#attributes.report_id#&resend_email&POSITION_CODE=#APPROVAL2_code#&SR_ID=#SR_ID#&W_ID_2=#Get_signs.W_ID#&REPORT_NAME=KOA_#attributes.sal_mon#_#attributes.sal_year#&type=-2','small');"><font color="blue"><strong>change the reviwer and send an e-mail to #get_emp_info(attributes.APPROVAL2_id,0,0)#</strong></font></a><br />
                        </cfif>
                        </cfif>
                        </td>
                        <cfelseif find('Rejec',Get_signs.WARNING_RESULT)>
                        <td style="#column_total#">
                        <font color="RED"> Rejected BY<br />#get_emp_info(Get_signs.POSITION_CODE,1,0)#<br />#sign_possition#</font></td>
                        <cfelseif find('Appro',Get_signs.WARNING_RESULT)>
                        <td style="#column_total#"><cfscript>getimpdata(2,Get_signs.POSITION_CODE);</cfscript>
                        Approved BY<br />#get_emp_info(Get_signs.POSITION_CODE,1,0)#<br />#sign_possition#<br /><br />#dateformat(Get_signs.APPROVE_DATE, 'dd-mmm-yyyy ')##TimeFormat(Get_signs.APPROVE_DATE,"HH:mm")#</td>
                        </cfif>
                      </cfloop>
                    </tr>
                    </table>
                    </td>
                    </tr>
                    </cfif>
                    </cfoutput>
                   </cfif>
   </table>
    </cfif>
  </div>
 
  <script>
	function re()
	{
     this.form.submit();
	}
	function state_color(typp)
	{
		if(typp != 3)
		  {
			  
              document.getElementById('collr').style.display='';
		  }
		  else
		  {
			 
			   document.getElementById('collr').style.display='none';
		  }
	}
	 <cfif len(attributes.Type_id)>
	   state_color(<cfoutput>#attributes.Type_id#</cfoutput>);
	 </cfif>
	//document.getElementById('detail_report_div').id="detail_report_divyy";
	//document.getElementById('detail_report_divxx').id="detail_report_div";
</script>

</cfif>