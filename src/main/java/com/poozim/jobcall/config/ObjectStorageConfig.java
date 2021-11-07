package com.poozim.jobcall.config;

import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.oracle.bmc.ConfigFileReader;
import com.oracle.bmc.ConfigFileReader.ConfigFile;
import com.oracle.bmc.auth.AuthenticationDetailsProvider;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;
import com.oracle.bmc.objectstorage.ObjectStorage;
import com.oracle.bmc.objectstorage.ObjectStorageClient;

@Configuration
public class ObjectStorageConfig {

	@Bean
	public ObjectStorage client() throws IOException {
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		return new ObjectStorageClient(provider);
	}
}
