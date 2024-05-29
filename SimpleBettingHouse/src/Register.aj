import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

import com.bettinghouse.*;

public aspect Register {
	
	pointcut success(User usuario, Person persona) : call(* com.bettinghouse..successfulSignUp(User, Person)) && args(usuario, persona);
	
    after(User usuario, Person persona) : success(usuario, persona) {
    	try(BufferedWriter bw = new BufferedWriter(new FileWriter("Register.txt", true))){
    		Calendar calendario = Calendar.getInstance();
    		String content = "Usuario Registrado: [nickname = " + usuario.getNickname() + ", password = " + usuario.getPassword() 
    		+ "] Fecha: [ " + calendario.getTime().toString() +" ]" ;
    		bw.append(content);
    		bw.newLine();
    		
    	}
    	catch (IOException ex) {
    		System.out.println(ex);
    	}
    	System.out.println("**** Usuario Creado ****");
    }
}
