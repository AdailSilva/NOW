package br.com.adailsilva.now.entity;

public class Now {

	private String currentDateAndTime;

	public Now(String currentDateAndTime) {
		super();
		this.currentDateAndTime = currentDateAndTime;
	}

	public String getCurrentDateAndTime() {
		return currentDateAndTime;
	}

}
