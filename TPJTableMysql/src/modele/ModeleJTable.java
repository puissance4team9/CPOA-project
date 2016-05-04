/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

import accesAuxDonnees.DaoEmp;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.AbstractTableModel;
import metier.Employe;

/**
 *
 * @author Alain
 */
public class ModeleJTable extends AbstractTableModel {
    // le conteneur de données

    private List<Employe> leConteneur;
    // le titre des champs du conteneur
    private String[] titre;
    // l'objet DAO pour mettre à jour le conteneur
    private DaoEmp leDaoEmp;

    public ModeleJTable(DaoEmp leDaoEmp) {
        // définition du conteneur d'étudiants
        this.leConteneur = new ArrayList<>();
        // définition des noms du champ
        this.titre = new String[]{"Numéro", "Nom", "Job"};
        // l'objet DAO utilisé
        this.leDaoEmp = leDaoEmp;
    }

    @Override
    public int getRowCount() {
        return leConteneur.size();
    }

    @Override
    public int getColumnCount() {
        return titre.length;
    }

    @Override
    public Object getValueAt(int row, int column) {
        Employe emp = leConteneur.get(row);
        if (column == 0) {
            return emp.getNumEmp();
        } else if (column == 1) {
            return emp.getNomEmp();
        } else {
            return emp.getJobEmp();
        }
    }

    @Override
    public String getColumnName(int column) {
        return titre[column];
    }

    public void insererEmploye(Employe emp) throws SQLException {
        leDaoEmp.insererEmploye(emp);
        leConteneur.add(emp);
        this.fireTableDataChanged();
    }

    public void supprimerEmploye(int ligne) throws SQLException {
        int numEmp = (int) getValueAt(ligne, 0);
        leDaoEmp.supprimerEmploye(numEmp);
        leConteneur.remove(ligne);
        this.fireTableDataChanged();
    }

    public void chargerLesEmployes() throws SQLException {
        leDaoEmp.lireLesEmployes(leConteneur);
        fireTableDataChanged();  // notification de modification des données à la vue
    }
}
