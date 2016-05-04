/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package metier;

/**
 *
 * @author Alain
 */
public class Employe {

    private int numEmp;
    private String nomEmp;
    private String jobEmp;

    public Employe(int numEmp, String nomEmp, String jobEmp) {
        this.numEmp = numEmp;
        this.nomEmp = nomEmp;
        this.jobEmp = jobEmp;
    }

    public Employe() {
    }

    public void setNumEmp(int numEmp) {
        this.numEmp = numEmp;
    }

    public void setNomEmp(String nomEmp) {
        this.nomEmp = nomEmp;
    }

    public void setJobEmp(String jobEmp) {
        this.jobEmp = jobEmp;
    }

    public int getNumEmp() {
        return numEmp;
    }

    public String getNomEmp() {
        return nomEmp;
    }

    public String getJobEmp() {
        return jobEmp;
    }

    @Override
    public String toString() {
        return "Emp{" + "numEmp=" + numEmp + ", nomEmp=" + nomEmp + ", jobEmp=" + jobEmp + '}';
    }
}
