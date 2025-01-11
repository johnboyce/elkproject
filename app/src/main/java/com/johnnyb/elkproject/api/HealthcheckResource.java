package com.johnnyb.elkproject.api;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("/healthcheck")
public class HealthcheckResource {

    private static final Logger logger = LoggerFactory.getLogger(HealthcheckResource.class);

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String healthcheck() {
        logger.info("Healthcheck");
        return "Healthcheck";
    }

}
