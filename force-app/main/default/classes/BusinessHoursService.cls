public with sharing class BusinessHoursService {

    @testVisible static BusinessHours defaultBH {
        
        get {
            if (defaultBH == null) { 
            	defaultBH = [SELECT Id FROM BusinessHours WHERE IsDefault = true];
            }
            return defaultBH;
        }
        
        private set;
        
    }
    
    public Long businessHourTimeDifference(Datetime startDate, Datetime endDate) {
        return BusinessHours.diff(defaultBH.id, startDate, endDate);
    }
    
    public String diffToString(Long diffTime) {
        Integer hours = Integer.valueOf(Math.abs(diffTime) / 3600000);
        Integer minutes = Integer.valueOf(Math.mod(Math.abs(diffTime), 3600000) / 60000);
        Integer seconds = Integer.valueOf(Math.mod(Math.mod(diffTime, 3600000), 60000) / 1000);
        String totalTime = formatDate(hours, minutes, seconds, 0);
     
        return totalTime;
    }
    
    private String formatDate(Integer hours, Integer minutes, Integer seconds, Integer milliseconds) {
        String strHours = hours.format();
		String strMinutes = minutes.format();
		String strSeconds = seconds.format();
		
		if (hours < 10L) {
			strHours = '0' + strHours; 
		}
		if (minutes < 10L) {
			strMinutes = '0' + strMinutes; 
		}
		if (seconds < 10L) {
			strSeconds = '0' + strSeconds; 
		}
		
		return strHours + ':' + strMinutes + ':' + strSeconds;
    }
}