/**
* @author Hamza CHAOUI
* @date Création 29/10/2015
* @date Modification
* @description classe util contains all utils methods
*/
public class ObjectUtil {
    // Class' name
    private static String CLASS_NAME = 'ObjectUtil';   
	public static final Map <String, Schema.SObjectType> schemaMap;

    public class Pair {
        public String key {get; set;}
        public String val {get; set;}
    }

    static {
        schemaMap = Schema.getGlobalDescribe();
    }

    /**
     * @author Hamza CHAOUI
     * @date 29/10/2015
     * @description Méthode permettant de retourner une liste de champs pour un objet donné
     * @param sObjectName String Nom du sObject
     * @return List<String> liste des champs du sObject en paramètre
     */
    public static List<String> getFieldsListFor(String sObjectName) {
        system.debug('## sObject : ' + sObjectName);
        Map <String, Schema.SObjectField> fieldMap = schemaMap.get(sObjectName).getDescribe().fields.getMap();
        List<String> fieldsList = new List<String>();
        for (Schema.SObjectField sfield : fieldMap.Values()) {
            schema.describefieldresult dfield = sfield.getDescribe();
            Pair field = new Pair();
            field.key = dfield.getname();
            fieldsList .add(field.key);
        }
        system.debug('## fieldsList : ' + fieldsList);
        return fieldsList;        
    }

    /**
     * @author Hamza CHAOUI
     * @date 29/10/2015
     * @description Méthode permettant de retourner une liste de champs pour un objet donné
     * @param sObjectName String Nom du sObject
     * @return String liste des champs du sObject en paramètre
     */
    public static String constructFieldListForQueryFrom(String sObjectName) {
        return constructFilteredFieldListForQueryFrom(sObjectName, '');
    }

    /**
     * @author HAmza CHAOUI
     * @date 29/10/2015
     * @description Returns all fields EXCEPT those ending with the specified string (example: "__pc" to exclude personAccount fields on account query)
     * @param sObjectName String Nom du sObject
     * @param notEndingFilter String specifies the endding name of the fields to omit
     * @return String liste des champs du sObject en paramètre
     */
    public static String constructFilteredFieldListForQueryFrom(String sObjectName, String notEndingFilter) {
        List<String> fieldsList = getFieldsListFor(sObjectName);
        String fieldsQuery = '';
        String notstartingFilter = 'SBQQ__';
        system.debug('## fieldsList : ' + fieldsList);
        for (String field : fieldsList) {
            if (String.isEmpty(notEndingFilter) || !field.endsWith(notEndingFilter) /*|| !field.startsWith(notstartingFilter)*/){
                fieldsQuery = fieldsQuery + '' + field + ',';
            }
        }

        return fieldsQuery.replace(fieldsQuery, fieldsQuery.substring(0, fieldsQuery.length() - 1));
    }    
    
    /** 
     * @author Hamza CHAOUI
     * @date Création 29/10/2015
     * @description sytem.debug of information in start of method
     * @param message informations to show in debug
     * @return N/A
     */
     public static void debugLogBegin(String className, String methodName, String message){
        system.debug('## >> BEGIN ['+className+']['+methodName+'][MESSAGE]: '+message);
     }  
    
   /** 
     * @author Hamza CHAOUI
     * @date Création 29/10/2015
     * @description sytem.debug of information in end of method
     * @param message informations to show in debug
     * @return N/A
     */
     public static void debugLogEnd(String className, String methodName, String message){
        system.debug('## >> END ['+className+']['+methodName+'][MESSAGE]: '+message);
     }
     
    /** 
     * @author Hamza CHAOUI
     * @date Création 29/10/2015
     * @description get a values for picklist field
     * @param sObjectAPI 
     * @param Field must be a picklist field
     * @return N/A
     */        
     public static List<String> getPicklistValues(String sObjectAPI,String Field){ 
        
             List<String> lstPickvals=new List<String>();
             Schema.sObjectType sobject_type = Schema.getGlobalDescribe().get(sObjectAPI).newSObject().getSObjectType(); 
             Map<String, Schema.SObjectField> field_map = sobject_type.getDescribe().fields.getMap();
             List<Schema.PicklistEntry> pick_list_values = field_map.get(Field).getDescribe().getPickListValues(); 
             for (Schema.PicklistEntry a : pick_list_values) { 
                  lstPickvals.add(a.getValue());
             }

             return lstPickvals;
     }      
     
    /**
    * @description checks if value is null or blank
    * @param String : string to check
    * @return boolean : true if null or blank
    */
    public static boolean IsEmpty(String Input){
        if (Input == null || Input == '') {
           return true;  
        } else  {
           return false;
        }
    }
    
	/** 
     * @author Mohammad LE DOZE
     * @date Création 13/01/2016
     * @description Get a recordtype id from a recordtype name
     * @param objectName : api nape of object
     * @param recordtypeName : api name of recordtype
     * @return Id of recordtype Name
     */   
    public static Id getRecordTypeId(String objectName, String recordtypeName){
        return schemaMap.get(objectName).getDescribe().getRecordTypeInfosByName().get(recordtypeName).getRecordTypeId();
    }
}