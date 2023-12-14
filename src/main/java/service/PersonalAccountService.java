package service;

import java.util.Optional;

import dao.PersonalAccountDao;
import dto.DtoPersonalAccount;
import entity.PersonalAccountEntity;

public class PersonalAccountService {

	private final static PersonalAccountService INCTANCE = new PersonalAccountService();
	private static PersonalAccountDao personalAccountDao = PersonalAccountDao.getInstance();

	private PersonalAccountService() {
	}

	public static PersonalAccountService getInctance() {
		return INCTANCE;
	}

	public Optional<Long> addAccount(DtoPersonalAccount account) {
		if (account.address().isBlank() || account.city().isBlank() || account.country().isBlank()
				|| account.name().isBlank() || account.email().isBlank() || account.phoneNumber().isBlank()
				|| account.surname().isBlank()) {
			return Optional.empty();
		}
		return personalAccountDao.insertAccount(new PersonalAccountEntity(account.email(), account.name(),
				account.surname(), account.country().toLowerCase(), account.city().toLowerCase(), account.address(),
				account.phoneNumber()));
	}

	public DtoPersonalAccount getById(Long id) {
		PersonalAccountEntity byIdEntity = personalAccountDao.getByID(id).get();
		return new DtoPersonalAccount(byIdEntity.getEmail(), byIdEntity.getName(), byIdEntity.getSurname(),
				byIdEntity.getCountry(), byIdEntity.getCity(), byIdEntity.getAddress(), byIdEntity.getPhoneNumber());
	}
}