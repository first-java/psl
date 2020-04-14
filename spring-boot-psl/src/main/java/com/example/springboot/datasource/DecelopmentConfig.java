/*
 * package com.example.springboot.datasource;
 * 
 * import org.apache.ibatis.session.SqlSessionFactory; import
 * org.mybatis.spring.SqlSessionFactoryBean; import
 * org.mybatis.spring.SqlSessionTemplate; import
 * org.mybatis.spring.annotation.MapperScan; import
 * org.springframework.beans.factory.annotation.Qualifier; import
 * org.springframework.boot.context.properties.ConfigurationProperties; import
 * org.springframework.boot.jdbc.DataSourceBuilder; import
 * org.springframework.context.annotation.Bean; import
 * org.springframework.context.annotation.Configuration; import
 * org.springframework.context.annotation.Primary; import
 * org.springframework.core.io.support.PathMatchingResourcePatternResolver;
 * import org.springframework.jdbc.datasource.DataSourceTransactionManager;
 * 
 * import javax.sql.DataSource;
 * 
 *//**
	 * @author syp
	 * @title: Datasource1Config
	 * @projectName databases
	 * @description: TODO
	 * @date 2019/4/2510:28
	 *//*
		 * @Configuration
		 * 
		 * @MapperScan(basePackages = "com.example.springboot.decelopment.dao",
		 * sqlSessionTemplateRef = "decelopmentSqlSessionTemplate") public class
		 * DecelopmentConfig {
		 * 
		 * @Bean(name = "decelopmentDataSource")
		 * 
		 * @ConfigurationProperties(prefix = "spring.datasource.decelopment")
		 * 
		 * @Primary public DataSource testDataSource() { return
		 * DataSourceBuilder.create().build(); }
		 * 
		 * @Bean(name = "decelopmentSqlSessionFactory")
		 * 
		 * @Primary public SqlSessionFactory
		 * testSqlSessionFactory(@Qualifier("decelopmentDataSource") DataSource
		 * dataSource) throws Exception { SqlSessionFactoryBean bean = new
		 * SqlSessionFactoryBean(); bean.setDataSource(dataSource);
		 * bean.setMapperLocations( new
		 * PathMatchingResourcePatternResolver().getResources(
		 * "classpath:mybatis/decelopmentmapper/**.xml")); return bean.getObject(); }
		 * 
		 * @Bean(name = "decelopmentTransactionManager")
		 * 
		 * @Primary public DataSourceTransactionManager testTransactionManager(
		 * 
		 * @Qualifier("decelopmentDataSource") DataSource dataSource) { return new
		 * DataSourceTransactionManager(dataSource); }
		 * 
		 * @Bean(name = "decelopmentSqlSessionTemplate")
		 * 
		 * @Primary public SqlSessionTemplate testSqlSessionTemplate(
		 * 
		 * @Qualifier("decelopmentSqlSessionFactory") SqlSessionFactory
		 * sqlSessionFactory) throws Exception { return new
		 * SqlSessionTemplate(sqlSessionFactory); }
		 * 
		 * }
		 */