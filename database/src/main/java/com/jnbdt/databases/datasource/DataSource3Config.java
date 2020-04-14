package com.jnbdt.databases.datasource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;

/**
 * @author syp
 * @title: DataSource3Config
 * @projectName databases
 * @description: TODO
 * @date 2019/4/2513:20
 */
@Configuration
@MapperScan(basePackages = "com.jnbdt.databases.mapper.mapper3", sqlSessionTemplateRef  = "database3SqlSessionTemplate")
public class DataSource3Config {

    @Bean(name="datasource3")
    @ConfigurationProperties(prefix = "spring.datasource.secondary3") //配置内容
    public DataSource dataSource(){
        //使用DataSourceBuilder创建一个datasource并构建出来
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "datasourceSqlSessionFactory")
    public SqlSessionFactory datasourceSqlSessionFactory(@Qualifier("datasource3") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(dataSource);
        bean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/mapper/StudentMapper3.xml"));
        return bean.getObject();
    }

    @Bean(name = "database3TransactionManager")
    public DataSourceTransactionManager testTransactionManager(@Qualifier("datasource3") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    @Bean(name = "database3SqlSessionTemplate")
    public SqlSessionTemplate testSqlSessionTemplate(@Qualifier("datasourceSqlSessionFactory") SqlSessionFactory sqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory);
    }

}
