package com.poozim.jobcall.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.google.common.base.Supplier;
import com.oracle.bmc.ClientConfiguration;
import com.oracle.bmc.ConfigFileReader;
import com.oracle.bmc.ConfigFileReader.ConfigFile;
import com.oracle.bmc.Region;
import com.oracle.bmc.auth.AuthenticationDetailsProvider;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;
import com.oracle.bmc.auth.SimpleAuthenticationDetailsProvider;
import com.oracle.bmc.auth.SimplePrivateKeySupplier;
import com.oracle.bmc.objectstorage.ObjectStorage;
import com.oracle.bmc.objectstorage.ObjectStorageClient;
import com.oracle.bmc.objectstorage.model.CreateBucketDetails;
import com.oracle.bmc.objectstorage.requests.CreateBucketRequest;
import com.oracle.bmc.objectstorage.requests.GetBucketRequest;
import com.oracle.bmc.objectstorage.requests.GetNamespaceRequest;
import com.oracle.bmc.objectstorage.responses.GetBucketResponse;
import com.oracle.bmc.objectstorage.responses.GetNamespaceResponse;

import org.glassfish.jersey.message.internal.HeaderUtils;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/*.xml", 
								   "file:src/main/webapp/WEB-INF/spring/appServlet/*.xml"})
public class OciUtilTest {

	@Test
	public void Test() throws IOException {
		final String compartmentId = "ocid1.tenancy.oc1..aaaaaaaa3leal2u527hmtcuhb4o7s5vhrf3cg4gupzytr3npcg5mbqtmjq4q";
        final String bucket = "bucket-20210728-1124";
		final String object = "";
        
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
//		Supplier<InputStream> privateKeySupplier = new SimplePrivateKeySupplier(config.get("key_file"));
		
		
//		AuthenticationDetailsProvider provider 
//	    = SimpleAuthenticationDetailsProvider.builder()
//	        .tenantId(config.get("tenancy"))
//	        .userId(config.get("user"))
//	        .fingerprint(config.get("fingerprint"))
//	        .privateKeySupplier(privateKeySupplier)
//	        .build();
//		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
//		ClientConfiguration clientConfig 
//	    = ClientConfiguration.builder()
//	        .connectionTimeoutMillis(3000)
//	        .readTimeoutMillis(60000)
//	        .build();
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		System.out.println("Getting the namespace.");
        GetNamespaceResponse namespaceResponse = client.getNamespace(GetNamespaceRequest.builder().build());
        
        String namespaceName = namespaceResponse.getValue();
        System.out.println("Name Space Name@@@@@@ : " + namespaceName);
		
		System.out.println("Creating Get bucket request");
        List<GetBucketRequest.Fields> fieldsList = new ArrayList<>(2);
        fieldsList.add(GetBucketRequest.Fields.ApproximateCount);
        fieldsList.add(GetBucketRequest.Fields.ApproximateSize);
        GetBucketRequest request =
                GetBucketRequest.builder()
                        .namespaceName(namespaceName)
                        .bucketName(bucket)
                        .fields(fieldsList)
                        .build();
        
        System.out.println("Fetching bucket details");
        GetBucketResponse response = client.getBucket(request);
        
        System.out.println("Bucket Name : " + response.getBucket().getName());
        System.out.println("Bucket Compartment : " + response.getBucket().getCompartmentId());
        System.out.println(
                "The Approximate total number of objects within this bucket : "
                        + response.getBucket().getApproximateCount());
        System.out.println(
                "The Approximate total size of objects within this bucket : "
                        + response.getBucket().getApproximateSize());

	}
	
}
