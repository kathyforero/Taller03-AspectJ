
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Calendar;

import com.bettinghouse.BettingHouse;

/*
public aspect Logger {

    pointcut success() : call(* BettingHouse.successfulSignUp*(..));
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje despu�s de haber creado un usuario 
    	System.out.println("** User created **");
    }
    }
*/

public aspect Logger{

    File fileLog = new File("log.txt");
    File fileReg = new File("Register.txt");
    Calendar cal = Calendar.getInstance();
    
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    
    pointcut successSignUp() : call(* BettingHouse.successfulSignUp*(..));
    after() : successSignUp() {
    	System.out.println("**** Usuario creado correctamente. ****");
    }
    after() : successSignUp() {
    	FileWriter fw = new FileWriter(fileReg);
    	BufferedWriter bw = new BufferedWriter(fw);
    	BettingHouse bh = (BettingHouse) thisJoinPoint.getTarget();
    	bw.write("Usuario Registrado: [nickname = ");
    	bw.flush();
    }
    
    pointcut successLogIn() : call(* BettingHouse.effectiveLogIn*(..));
    after() : successLogIn() {
    	System.out.println("**** Usuario inició sesión correctamente. ****");
    }	
    	
    pointcut successLogOut() : call(* BettingHouse.effectiveLogOut*(..));
    after() : successLogOut() {
        System.out.println("**** Usuario cerró sesión correctamente. ****");	
    
    }
}