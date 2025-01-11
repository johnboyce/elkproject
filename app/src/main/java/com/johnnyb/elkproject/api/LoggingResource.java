package com.johnnyb.elkproject.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.slf4j.MDC;

@Path("/log")
public class LoggingResource {

    private static final Logger logger = LoggerFactory.getLogger(LoggingResource.class);

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String logGeneralMessage() {
        // Set MDC fields
        MDC.put("request.id", java.util.UUID.randomUUID().toString());

        // Log a message
        logger.info("Logging with MDC fields: service.name and request.id");
        // Clear MDC fields after logging (optional but recommended)
        //  MDC.clear();
        logger.info("INFO: General logging endpoint was accessed");
        logger.debug("DEBUG: General debug details here");
        logger.error("ERROR: Simulated general error message");
        return "General log messages generated!";
    }

    @GET
    @Path("/specific")
    @Produces(MediaType.TEXT_PLAIN)
    public String logSpecificMessage() {
        logger.info("INFO: Specific logging endpoint was accessed");
        logger.debug("DEBUG: Specific debug details here");
        logger.warn("WARN: Simulated specific warning message");
        return "Specific log messages generated!";
    }
}
