package com.poozim.jobcall.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.bmc.objectstorage.ObjectStorage;
import com.oracle.bmc.objectstorage.model.CreateBucketDetails;
import com.oracle.bmc.objectstorage.model.CreatePreauthenticatedRequestDetails;
import com.oracle.bmc.objectstorage.model.ListObjects;
import com.oracle.bmc.objectstorage.model.ObjectSummary;
import com.oracle.bmc.objectstorage.model.CreatePreauthenticatedRequestDetails.AccessType;
import com.oracle.bmc.objectstorage.requests.CreateBucketRequest;
import com.oracle.bmc.objectstorage.requests.CreatePreauthenticatedRequestRequest;
import com.oracle.bmc.objectstorage.requests.DeleteObjectRequest;
import com.oracle.bmc.objectstorage.requests.GetObjectRequest;
import com.oracle.bmc.objectstorage.requests.ListObjectsRequest;
import com.oracle.bmc.objectstorage.requests.PutObjectRequest;
import com.oracle.bmc.objectstorage.responses.CreateBucketResponse;
import com.oracle.bmc.objectstorage.responses.CreatePreauthenticatedRequestResponse;
import com.oracle.bmc.objectstorage.responses.DeleteBucketResponse;
import com.oracle.bmc.objectstorage.responses.DeleteObjectResponse;
import com.oracle.bmc.objectstorage.responses.GetObjectResponse;
import com.oracle.bmc.objectstorage.responses.ListObjectsResponse;
import com.oracle.bmc.objectstorage.transfer.DownloadConfiguration;
import com.oracle.bmc.objectstorage.transfer.DownloadManager;
import com.oracle.bmc.objectstorage.transfer.UploadConfiguration;
import com.oracle.bmc.objectstorage.transfer.UploadManager;
import com.oracle.bmc.objectstorage.transfer.UploadManager.UploadRequest;
import com.oracle.bmc.objectstorage.transfer.UploadManager.UploadResponse;

@Component
public class OciUtil {
	public static PropertiesUil propsUtil;
	public static String compartmentId;
	public static String namespaceName;
	
	public static String host = "https://objectstorage.ap-seoul-1.oraclecloud.com";
	
	@Autowired
	static ObjectStorage client;
	
	public OciUtil() throws IOException {
		propsUtil = new PropertiesUil();
		this.compartmentId = propsUtil.getProperty("compartment_ocid");
		this.namespaceName = propsUtil.getProperty("storage_namespace");
	}
	
	/**
	 * 버킷 생성 메서드
	 * 
	 * @param 생성할 버킷 이름
	 * @return 생성된 버킷 이름
	 * @throws IOException
	 */
	public static String createBucket(String bucketName) throws IOException {
		CreateBucketDetails createBucketDetails =
        		CreateBucketDetails.builder()
        			.compartmentId(compartmentId)
        			.name(bucketName)
        			.build();
        
        CreateBucketRequest request = 
        		CreateBucketRequest.builder()
        			.namespaceName(namespaceName)
        			.createBucketDetails(createBucketDetails)
        			.build();
        			
        
        CreateBucketResponse response = client.createBucket(request);
        
		return response.getBucket().getName();
	}
	
	/**
	 * 
	 * @param 사전인증 등록할 버킷이름
	 * @param 사전인증 만료 날짜
	 * @return Access URI Code
	 * @throws IOException
	 */
	public static String createPreAuth(String bucketName, Date expireDate) throws IOException {
		CreatePreauthenticatedRequestDetails details = 
        		CreatePreauthenticatedRequestDetails.builder()
        			.accessType(AccessType.AnyObjectRead)
        			.name(bucketName + "_preAuth")
        			.timeExpires(expireDate)
        			.build();
        
        CreatePreauthenticatedRequestRequest request =
        		CreatePreauthenticatedRequestRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.createPreauthenticatedRequestDetails(details)
        			.build();
        
        CreatePreauthenticatedRequestResponse response = client.createPreauthenticatedRequest(request);
        
        String accessUri = response.getPreauthenticatedRequest().getAccessUri();
        String preAuthId = response.getPreauthenticatedRequest().getId();
        
		return accessUri.substring(accessUri.indexOf("/p/") + 3, accessUri.indexOf("/n/"));
	}
	
	/**
	 * 
	 * @param bucketName
	 * @param file
	 * @return 성공 1, 실패 0
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	public static int createObject(String bucketName, MultipartFile file) throws IllegalStateException, IOException {
		UploadConfiguration uploadConfiguration =
                UploadConfiguration.builder()
                        .allowMultipartUploads(true)
                        .allowParallelUploads(true)
                        .build();
		
		UploadManager uploadManager = new UploadManager(client, uploadConfiguration);
		
        Map<String, String> metadata = null;
        String contentType = file.getContentType();
        
        String contentEncoding = null;
        String contentLanguage = null;
        
        String objectName = file.getOriginalFilename();
        String ext = objectName.substring(objectName.lastIndexOf(".") + 1);
        
        File object = new File(file.getOriginalFilename());
        file.transferTo(object);
        
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
	                UploadRequest.builder(object).allowOverwrite(true).build(request);
		
		UploadResponse response = uploadManager.upload(uploadDetails);
        
		int res = (response == null? 0 : 1);
		
        return res;
	}
	
	/**
	 * 
	 * @param bucketName 버킷명
	 * @param objectName 파일명
	 * @param saveFileName 저장할 파일 경로와 이름
	 * @throws Exception
	 */
	public static void downloadObject(String bucketName, String objectName, String saveFileName) throws Exception {
		DownloadConfiguration downloadConfiguration =
                DownloadConfiguration.builder()
                        .parallelDownloads(3)
                        .maxRetries(3)
                        .multipartDownloadThresholdInBytes(6 * 1024 * 1024)
                        .partSizeInBytes(4 * 1024 * 1024)
                        .build();

        DownloadManager downloadManager = new DownloadManager(client, downloadConfiguration);
		
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
        OutputStream outputStream = new FileOutputStream(saveFileName);
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
	}
	
	public static String getObjectSrc(String preAuth ,String bucketName, String objectName) {
		String src = host + "/p/" + preAuth + "/n/" + namespaceName + "/b/" + bucketName + "/o/" + objectName;
		
		return src;
	}
	
	public static int deleteObject(String bucketName, String objectName) {
		DeleteObjectRequest request = 
        		DeleteObjectRequest.builder()
        			.bucketName(bucketName)
        			.namespaceName(namespaceName)
        			.objectName(objectName)
        			.build();
        
		DeleteObjectResponse response = client.deleteObject(request);
		
		int res = (response == null? 0 : 1);
        return res;
	}
	
	public static List<ObjectSummary> getObjectList(String bucketName, String prefix) {
		ListObjectsRequest request =
        		ListObjectsRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.fields("size, md5, timeCreated, timeModified")
        			.prefix(prefix)
        			.build();
        
        ListObjectsResponse response = client.listObjects(request);
        
        ListObjects list = response.getListObjects();
        List<ObjectSummary> objectList = list.getObjects();
        
		return objectList;
	}
	
	public static ObjectSummary getObjectOne(String bucketName, String objectName) {
		ListObjectsRequest request =
        		ListObjectsRequest.builder()
        			.namespaceName(namespaceName)
        			.bucketName(bucketName)
        			.fields("size, md5, timeCreated, timeModified")
        			.prefix(objectName)
        			.build();
        
        ListObjectsResponse response = client.listObjects(request);
        
        ListObjects list = response.getListObjects();
        List<ObjectSummary> objectList = list.getObjects();
        
		return objectList.get(0);
	}
	
}
