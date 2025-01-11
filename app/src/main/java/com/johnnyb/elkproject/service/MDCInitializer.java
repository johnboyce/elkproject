package com.johnnyb.elkproject.service;

import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.ApplicationScoped;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

@ApplicationScoped
public class MDCInitializer {
    Logger logger = LoggerFactory.getLogger(MDCInitializer.class);

    @PostConstruct
    public void initializeMDC() {
        logger.info("Initializing MDC");
        MDC.put("service.name", "elkproject");
    }
}