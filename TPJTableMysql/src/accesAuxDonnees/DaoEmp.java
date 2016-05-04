/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package accesAuxDonnees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import metier.Employe;

/**
 *
 * @author Alain
 */
public class DaoEmp {

    private final Connection connexion;

    public DaoEmp(Connection connexion) throws SQLException {
        this.connexion = connexion;     
    }

    public void lireLesEmployes(List<Employe> lesEmployes) throws SQLException {    
        String requete = "select * from EMP";
        PreparedStatement pstmt = connexion.prepareStatement(requete);
        ResultSet rset = pstmt.executeQuery(requete);
        while (rset.next()) {       // traitement du résulat
            int num = rset.getInt(1);
            String nom = rset.getString(2);
            String job = rset.getString(3);
            Employe temp = new Employe(num, nom, job);
            lesEmployes.add(temp);
        }
        rset.close();
        pstmt.close();     
    }

    public void supprimerEmploye(int numEmp) throws SQLException {
        String requete = "delete from EMP where empno = ?";
        PreparedStatement pstmt = connexion.prepareStatement(requete);
        pstmt.setInt(1, numEmp);
        pstmt.executeUpdate();
        pstmt.close();
    }

    public void insererEmploye(Employe emp) throws SQLException {
        String requete = "insert into EMP (empno, ename, job) values(?,?,?)";
        PreparedStatement pstmt = connexion.prepareStatement(requete);
        pstmt.setInt(1, emp.getNumEmp());
        pstmt.setString(2, emp.getNomEmp());
        pstmt.setString(3, emp.getJobEmp());
        pstmt.executeUpdate();
        pstmt.close();
    }
}
