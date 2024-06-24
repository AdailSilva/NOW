package br.com.adailsilva.now.service.impl;

import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.Instant;
import org.springframework.stereotype.Service;

import br.com.adailsilva.now.service.NowService;

@Service
public class NowServiceImpl implements NowService {

	/*
	 * Get now date with time zone.
	 */

	@Override
	public DateTime getNow() {
		return Instant.now().toDateTime(DateTimeZone.forID("America/Fortaleza"));
	}

}
