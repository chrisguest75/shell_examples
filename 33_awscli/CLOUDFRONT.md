# CLOUDFRONT

Demonstrate how to use the `awscli` with CloudFront  

## Table of contents

- [CLOUDFRONT](#cloudfront)
  - [Table of contents](#table-of-contents)
  - [Reason](#reason)
  - [Listing](#listing)
  - [Iteration](#iteration)
  - [Resources](#resources)

## Reason

Amazon CloudFront is a web service provided by Amazon Web Services (AWS) that offers a Content Delivery Network (CDN) service. A CDN is a distributed network of servers that provides web content to users with high availability and high performance. CloudFront delivers a wide range of content, including dynamic, static, streaming, and interactive content, by routing each user request to the edge location that can best serve the user's content. This is typically the nearest edge location in terms of Internet distance, which minimizes the number of networks that the data passes through, reducing latency and improving load times.  

Key features of Amazon CloudFront include:

* Edge Locations: CloudFront uses a global network of edge locations (data centers) that cache copies of your content close to your users to minimize latency.  
* Integration with AWS: CloudFront is deeply integrated with other AWS services like Amazon S3 (Simple Storage Service), AWS WAF (Web Application Firewall), Amazon EC2 (Elastic Compute Cloud), and Amazon Route 53 (a scalable DNS web service). This allows for easy distribution of content stored on AWS and protection against network and application layer attacks.  
* Security: It offers various security features like HTTPS and TLS encryption, AWS WAF integration, and AWS Shield for DDoS protection. Additionally, it provides field-level encryption and supports AWS Certificate Manager for managing SSL/TLS certificates.  
* Customizability: You can customize the way CloudFront delivers content with various caching behaviors, including the ability to customize query string parameters, cookies, and headers that are forwarded to your origin.  
* Dynamic Content Acceleration: CloudFront is not only for static content; it also offers optimized network protocols and routes to improve the performance of dynamic content, which is not cached at the edge locations.  
* Streaming Capabilities: CloudFront supports multiple methods for streaming content and works with services like AWS Elemental MediaStore and AWS Elemental MediaPackage to deliver video content.  
* Pricing and Cost: CloudFront has a pay-as-you-go pricing model, where you only pay for the content that you deliver through the service. Pricing varies based on geographic region and the amount of data transferred.  
* DevOps and Automation: CloudFront can be automated and managed through AWS SDKs, the AWS Management Console, and AWS CloudFormation templates, enabling infrastructure as code (IaC) practices.  
* Content Invalidation: It allows you to remove a file from the cache before it naturally expires so that you can update your content at any time.  
* Reporting and Analytics: CloudFront offers detailed reports on viewer requests, data transfer, and cache statistics to understand user engagement.  
* Origin Shield: This is an additional caching layer that can help reduce the load on your origin servers and further improve cache hit ratios, which can be particularly beneficial for popular content.  

CloudFront is used by many businesses to accelerate content delivery, ensure high availability, protect against web attacks, and to deliver a better user experience. The service can serve a wide range of web content, including HTML pages, JavaScript files, stylesheets, images, and video.  

TODO:

* Creating invalidations for files.  
* query parameter caching.  

NOTES:

* To get directory listing on an S3 bucket through CloudFront you have to enable query parameters to be passed through. Otherwise only the root page is enabled.  

## Listing

```sh
# find a particular distribution
aws --no-cli-pager cloudfront list-distributions | jq '.DistributionList.Items[] | select(.Id == "XXXXXXXXXXXX")'

# get configuration
aws --no-cli-pager cloudfront get-distribution-config --id "XXXXXXXXXXXX"
```

## Iteration

```sh
# make a request to the root of each distribution
export AWS_PROFILE=myprofile
aws --no-cli-pager cloudfront list-distributions | jq '.DistributionList.Items[].DomainName' --raw-output | while read url; do 
    echo "----"
    echo "https://${url}"
    curl -sL "https://${url}"
    echo "----"
done

# get domain names.  
aws --no-cli-pager cloudfront list-distributions | jq '.DistributionList.Items[] | [.DomainName, .Origins.Items[].DomainName]'

# pull out a particular distribution
aws --no-cli-pager cloudfront list-distributions | jq '.DistributionList.Items[2].Origins.Items[]'
```

## Resources

* Force CloudFront distribution/file update [here](https://stackoverflow.com/questions/1268158/force-cloudfront-distribution-file-update)
* Caching content based on query string parameters [here](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/QueryStringParameters.html)
* Slashing CloudFront change propagation times in 2020 – recent changes and looking forward [here](https://aws.amazon.com/blogs/networking-and-content-delivery/slashing-cloudfront-change-propagation-times-in-2020-recent-changes-and-looking-forward/)  
