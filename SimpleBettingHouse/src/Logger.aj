import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

import com.bettinghouse.Person;
import com.bettinghouse.User;

public aspect Logger {
	
	pointcut success(User usuario) :
		call(* com.bettinghouse..effectiveLog*(..)) && args(usuario);
	
    after(User usuario) : success(usuario) {
    	try(BufferedWriter bw = new BufferedWriter(new FileWriter("Log.txt", true))){
    		Calendar calendario = Calendar.getInstance();
    		String method = thisJoinPoint.getSignature().getName();
    		String content = "Sesion ";
    		if (method.endsWith("In")) {
    			content +="iniciada ";
    		}
    		else if (method.endsWith("Out")) {
    			content += "cerrada ";
    		}
    		else {
    			content += "xd";
    		}
    		content += "por usuario: [" + usuario.getNickname() + "] \tFecha: [ " + calendario.getTime().toString() +" ]" ;
    		bw.append(content);
    		bw.newLine();
    		
    	}
    	catch (IOException ex) {
    		System.out.println(ex);
    	}    	
    }
}

