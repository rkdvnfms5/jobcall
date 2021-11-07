package com.poozim.jobcall.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.oracle.bmc.ConfigFileReader;
import com.oracle.bmc.ConfigFileReader.ConfigFile;
import com.oracle.bmc.Region;
import com.oracle.bmc.auth.AuthenticationDetailsProvider;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;
import com.oracle.bmc.objectstorage.ObjectStorage;
import com.oracle.bmc.objectstorage.ObjectStorageClient;
import com.oracle.bmc.objectstorage.model.Bucket;
import com.oracle.bmc.objectstorage.model.CreateBucketDetails;
import com.oracle.bmc.objectstorage.model.CreatePreauthenticatedRequestDetails;
import com.oracle.bmc.objectstorage.model.CreatePreauthenticatedRequestDetails.AccessType;
import com.oracle.bmc.objectstorage.model.ListObjects;
import com.oracle.bmc.objectstorage.model.ObjectSummary;
import com.oracle.bmc.objectstorage.requests.CreateBucketRequest;
import com.oracle.bmc.objectstorage.requests.CreatePreauthenticatedRequestRequest;
import com.oracle.bmc.objectstorage.requests.DeleteBucketRequest;
import com.oracle.bmc.objectstorage.requests.DeleteObjectRequest;
import com.oracle.bmc.objectstorage.requests.DeletePreauthenticatedRequestRequest;
import com.oracle.bmc.objectstorage.requests.GetBucketRequest;
import com.oracle.bmc.objectstorage.requests.GetNamespaceRequest;
import com.oracle.bmc.objectstorage.requests.GetObjectRequest;
import com.oracle.bmc.objectstorage.requests.GetPreauthenticatedRequestRequest;
import com.oracle.bmc.objectstorage.requests.ListObjectsRequest;
import com.oracle.bmc.objectstorage.requests.PutObjectRequest;
import com.oracle.bmc.objectstorage.responses.CreateBucketResponse;
import com.oracle.bmc.objectstorage.responses.CreatePreauthenticatedRequestResponse;
import com.oracle.bmc.objectstorage.responses.DeleteBucketResponse;
import com.oracle.bmc.objectstorage.responses.GetBucketResponse;
import com.oracle.bmc.objectstorage.responses.GetNamespaceResponse;
import com.oracle.bmc.objectstorage.responses.GetObjectResponse;
import com.oracle.bmc.objectstorage.responses.GetPreauthenticatedRequestResponse;
import com.oracle.bmc.objectstorage.responses.ListObjectsResponse;
import com.oracle.bmc.objectstorage.transfer.*;
import com.oracle.bmc.objectstorage.transfer.UploadManager.UploadRequest;
import com.oracle.bmc.objectstorage.transfer.UploadManager.UploadResponse;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/*.xml", 
								   "file:src/main/webapp/WEB-INF/spring/appServlet/*.xml"})
public class OciUtilTest {

	public void Test() throws Exception {
		final String compartmentId = "ocid1.tenancy.oc1..aaaaaaaa3leal2u527hmtcuhb4o7s5vhrf3cg4gupzytr3npcg5mbqtmjq4q";
        final String bucket = "bucket-20210728-1124";
		final String object = "";
        
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");

		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
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
        client.close();

	}
	
	
	public void UploadObjectTest() throws Exception {
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		
		//upload object
		UploadConfiguration uploadConfiguration =
                UploadConfiguration.builder()
                        .allowMultipartUploads(true)
                        .allowParallelUploads(true)
                        .build();
		
		UploadManager uploadManager = new UploadManager(client, uploadConfiguration);
		
		String namespaceName = "cnwovahmge5s";
        String bucketName = "bucket-20210728-1124";
        String objectName = "test_object2.jpg";
        Map<String, String> metadata = null;
        String contentType = "image/jpg";
        
        String contentEncoding = null;
        String contentLanguage = null;
        
        File body = new File("/test.jpg");

        PutObjectRequest request =
	                PutObjectRequest.builder()
	                        .bucketName(bucketName)
	                        .namespaceName(namespaceName)
	                        .objectName(objectName)
	                        .contentType(contentType)
	                        .contentLanguage(contentLanguage)
	                        .contentEncoding(contentEncoding)
	                        .opcMeta(metadata)
	                        .build();
		
		
		UploadRequest uploadDetails =
	                UploadRequest.builder(body).allowOverwrite(true).build(request);
		
		UploadResponse response = uploadManager.upload(uploadDetails);
        System.out.println(response);
        
        // fetch the object just uploaded
        GetObjectResponse getResponse =
                client.getObject(
                        GetObjectRequest.builder()
                                .namespaceName(namespaceName)
                                .bucketName(bucketName)
                                .objectName(objectName)
                                .build());
        
        System.out.println(getResponse.getOpcMeta());
        System.out.println(getResponse.getOpcClientRequestId());
        System.out.println(getResponse.getOpcRequestId());
        client.close();
	}
	
	public void getObjectOneTest() throws Exception {
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		String namespaceName = "cnwovahmge5s";
        String bucketName = "bucket-20210728-1124";
        String objectName = "test_object2.jpg";
        
        /*
        GetObjectRequest request =
        		GetObjectRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.objectName(objectName)
        			.build();
        
        GetObjectResponse response = client.getObject(request);
        System.out.println(response);
        response.getInputStream().
        */
        
        ListObjectsRequest request =
        		ListObjectsRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.fields("size, md5, timeCreated, timeModified")
        			.prefix("test_object2.jpg")
        			.build();
        
        ListObjectsResponse response = client.listObjects(request);
        
        ListObjects list = response.getListObjects();
        List<ObjectSummary> objectList = list.getObjects();
        
        for(int i=0; i<objectList.size(); i++) {
        	System.out.println("====================");
        	System.out.println("@@@@@@@@@@@@@@@@@ getName : " + objectList.get(i).getName());
        	System.out.println("@@@@@@@@@@@@@@@@@ getArchivalState : " + objectList.get(i).getArchivalState());
        	System.out.println("@@@@@@@@@@@@@@@@@ getSize : " + objectList.get(i).getSize());
        	System.out.println("@@@@@@@@@@@@@@@@@ getTimeCreated : " + objectList.get(i).getTimeCreated());
        	System.out.println("@@@@@@@@@@@@@@@@@ getTimeModified : " + objectList.get(i).getTimeModified());
        }
        
        client.close();

	}
	
	public void getObjectListTest() throws Exception {
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		String namespaceName = "cnwovahmge5s";
        String bucketName = "bucket-20210728-1124";
        
        ListObjectsRequest request =
        		ListObjectsRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.fields("size, md5, timeCreated, timeModified")
        			.build();
        
        ListObjectsResponse response = client.listObjects(request);
        
        ListObjects list = response.getListObjects();
        List<ObjectSummary> objectList = list.getObjects();
        
        
        for(int i=0; i<objectList.size(); i++) {
        	System.out.println("====================");
        	System.out.println("@@@@@@@@@@@@@@@@@ getName : " + objectList.get(i).getName());
        	System.out.println("@@@@@@@@@@@@@@@@@ getArchivalState : " + objectList.get(i).getArchivalState());
        	System.out.println("@@@@@@@@@@@@@@@@@ getSize : " + objectList.get(i).getSize());
        	System.out.println("@@@@@@@@@@@@@@@@@ getTimeCreated : " + objectList.get(i).getTimeCreated());
        	System.out.println("@@@@@@@@@@@@@@@@@ getTimeModified : " + objectList.get(i).getTimeModified());
        }
        
        System.out.println(response.getListObjects());
        client.close();
	}
	
	public void DownloadObjectTest() throws Exception {
		//basic setting
        final String bucket = "bucket-20210728-1124";
		
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		//end basic setting
		
		DownloadConfiguration downloadConfiguration =
                DownloadConfiguration.builder()
                        .parallelDownloads(3)
                        .maxRetries(3)
                        .multipartDownloadThresholdInBytes(6 * 1024 * 1024)
                        .partSizeInBytes(4 * 1024 * 1024)
                        .build();

        DownloadManager downloadManager = new DownloadManager(client, downloadConfiguration);
		
        String namespaceName = "cnwovahmge5s";
        String bucketName = bucket;
        String objectName = "test_object2.jpg";
        String outputFileName = "/www/test_out_object.jpg";
        
        GetObjectRequest request =
                GetObjectRequest.builder()
                        .namespaceName(namespaceName)
                        .bucketName(bucketName)
                        .objectName(objectName)
                        .build();
        
        // download request and print result
        GetObjectResponse response = downloadManager.getObject(request);
        System.out.println("Content length: " + response.getContentLength() + " bytes");

        // use the stream contents; make sure to close the stream, e.g. by using try-with-resources
        InputStream stream = response.getInputStream();
        OutputStream outputStream = new FileOutputStream(outputFileName);
        try {
        	// use fileStream
            byte[] buf = new byte[8192];
            int bytesRead;
            while ((bytesRead = stream.read(buf)) > 0) {
                outputStream.write(buf, 0, bytesRead);
            }
        } // try-with-resources automatically closes streams
        finally {
        	stream.close();
        	outputStream.close();
		}
        System.out.println("File size: " + new File(outputFileName).length() + " bytes");

        // or even simpler, if targetting a file:
        response = downloadManager.downloadObjectToFile(request, new File(outputFileName));
        System.out.println("Content length: " + response.getContentLength() + " bytes");
        System.out.println("File size: " + new File(outputFileName).length() + " bytes");
        client.close();
	}
	
	public void deleteObjectTest() throws Exception {
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		String namespaceName = "cnwovahmge5s";
        String bucketName = "bucket-20210728-1124";

		
        DeleteObjectRequest request = 
        		DeleteObjectRequest.builder()
        			.bucketName(bucketName)
        			.namespaceName(namespaceName)
        			.objectName("test_object")
        			.build();
        		
        
        client.deleteObject(request);
        client.close();
	}
	
	public void createBucketTest() throws Exception {
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		String namespaceName = "cnwovahmge5s";
        String compartmentId = config.get("tenancy");
        
        CreateBucketDetails createBucketDetails =
        		CreateBucketDetails.builder()
        			.compartmentId(compartmentId)
        			.name("testBucket")
        			.build();
        
        CreateBucketRequest request = 
        		CreateBucketRequest.builder()
        			.namespaceName(namespaceName)
        			.createBucketDetails(createBucketDetails)
        			.build();
        			
        
        CreateBucketResponse response = client.createBucket(request);
        System.out.println(response);
        client.close();
	}
	
	public void getBucketTest() throws Exception {
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		String namespaceName = "cnwovahmge5s";
        String bucketName = "bucket-20210728-1124";
        String objectName = "test_object2.jpg";
        String compartmentId = config.get("tenancy");
        
        GetBucketRequest request =
        		GetBucketRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.build();
        			
        
        GetBucketResponse response = client.getBucket(request);
        
        Bucket bucket = response.getBucket();
        System.out.println("Bucket Name : " + bucket.getName());
        System.out.println("Bucket Compartment : " + bucket.getCompartmentId());
        System.out.println(
                "The Approximate total number of objects within this bucket : "
                        + bucket.getApproximateCount());
        System.out.println(
                "The Approximate total size of objects within this bucket : "
                        + bucket.getApproximateSize());
        client.close();
	}
	
	@Test
	public void deleteBucketTest() throws Exception {
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		String namespaceName = "cnwovahmge5s";
        String bucketName = "testBucket";
        
        DeleteBucketRequest request =
        		DeleteBucketRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.build();
        
        DeleteBucketResponse response = client.deleteBucket(request);
        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ response : " + response);
        System.out.println("status code : " + response.get__httpStatusCode__());
        client.close();
	}
	
	
	public void getPreAuth() throws Exception{
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		String namespaceName = "cnwovahmge5s";
        String bucketName = "bucket-20210728-1124";
        
        GetPreauthenticatedRequestRequest request =
        		GetPreauthenticatedRequestRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.parId("zbmLFOSoKWHRB0y4c3cqKdq5tLQfC2VPQLrQ6Mg/o7dxaangC7sSzKfN9E8t7PqA")	//parId 필수
        			.build();
        
        
        GetPreauthenticatedRequestResponse response = client.getPreauthenticatedRequest(request);
        System.out.println(response);
	}
	
	public void createPreAuth() throws Exception{
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		String namespaceName = "cnwovahmge5s";
        String bucketName = "bucket-20210728-1124";
        
        Date expireDate = new Date(2021, 11, 21);
        
        CreatePreauthenticatedRequestDetails details = 
        		CreatePreauthenticatedRequestDetails.builder()
        			.accessType(AccessType.AnyObjectRead)
        			.name("testParName")
        			.timeExpires(expireDate)
        			.build();
        
        CreatePreauthenticatedRequestRequest request =
        		CreatePreauthenticatedRequestRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.createPreauthenticatedRequestDetails(details)
        			.build();
        
        CreatePreauthenticatedRequestResponse response = client.createPreauthenticatedRequest(request);
        System.out.println(response.getPreauthenticatedRequest().getAccessUri());
        System.out.println(response.getPreauthenticatedRequest().getId());
        
        client.close();
        
	}
	
	public void deletePreAuth() throws Exception{
		ConfigFile config = ConfigFileReader.parse("~/ocikey/config", "DEFAULT");
		
		AuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider(config);
		
		ObjectStorage client = new ObjectStorageClient(provider);
		client.setRegion(Region.AP_SEOUL_1);
		
		String namespaceName = "cnwovahmge5s";
        String bucketName = "bucket-20210728-1124";
        
        DeletePreauthenticatedRequestRequest request =
        		DeletePreauthenticatedRequestRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.parId("JRmU2idHv3nzX4RI47sxm+zHffo98pzo4sYqFriznD7zFAhjc8uiu7xHTy3RXBGQ")
        			.build();
        
        client.deletePreauthenticatedRequest(request);
        
        client.close();
	}
	
}
