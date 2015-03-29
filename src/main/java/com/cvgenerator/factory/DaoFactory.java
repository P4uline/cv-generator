package com.cvgenerator.factory;

import com.cvgenerator.dao.CvDao;
import com.cvgenerator.dao.Dao;
import com.cvgenerator.dao.PersonDao;

public class DaoFactory {
	
	public static Dao dao;
	
	public static void setDao(Dao newDao) {
		dao = newDao;
	}

	public static Dao getDao(String type) {
		
		if (dao != null) {
			return dao;
		} else {
			switch(type) {
				case "cv" : 	return new CvDao();
				case "person" : return new PersonDao();
				default : throw new IllegalStateException();
			}
		}
	}
}
