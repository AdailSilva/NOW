package br.com.adailsilva.now.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.adailsilva.now.entity.Now;
import br.com.adailsilva.now.service.NowService;

@RestController
@RequestMapping(value = "/")
public class NowController {

	@Autowired
	private NowService nowService;

	@GetMapping(value = "/now", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Now> getNow() {

		final String nowString = String.format(
				"Get now date with time zone (America/Fortaleza). Current Date and Time: %s.",
				this.nowService.getNow());

		return ResponseEntity.ok(new Now(nowString));
	}

}
