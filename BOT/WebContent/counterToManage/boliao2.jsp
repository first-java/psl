<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>

<body>
	<!--这是我们的View-->
	<div id="app">{{ message }}</div>
	<div id="app-2">
		<span v-bind:title="message"> 鼠标悬停几秒钟查看此处动态绑定的提示信息！ </span>
	</div>
	<div id="app-3">
		<p v-if="seen">现在你看到我了</p>
	</div>
	<div id="app-4">
		<ol>
			<li v-for="todo in todos">{{ todo.text }}</li>
		</ol>
	</div>
	<div id="app-5">
		<p>{{ message }}</p>
		<button v-on:click="reverseMessage">反转消息</button>
	</div>
	<div id="app-6">
		<p>{{ message }}</p>
		<input v-model="message">
	</div>
	<div id="app-7">
		<ol>
			<!--
      现在我们为每个 todo-item 提供 todo 对象
      todo 对象是变量，即其内容可以是动态的。
      我们也需要为每个组件提供一个“key”，稍后再
      作详细解释。
    -->
			<todo-item v-for="item in groceryList" v-bind:todo="item"
				v-bind:key="item.id"></todo-item>
		</ol>
	</div>
	<div id="example">
		<p>Original message: "{{ message }}"</p>
		<p>Computed reversed message: "{{ reversedMessage }}"</p>
		<p>Reversed message: "{{ reversedMessage() }}"</p>

	</div>
	<div id="demo">{{ fullName }}</div>

	<div id="watch-example">
		<p>
			Ask a yes/no question: <input v-model="question">
		</p>
		<p>{{ answer }}</p>
	</div>

	<div v-bind:class="classObject"></div>
	<div id='example-3'>
		<input type="checkbox" id="jack" value="Jack" v-model="checkedNames">
		<label for="jack">Jack</label> <input type="checkbox" id="john"
			value="John" v-model="checkedNames"> <label for="john">John</label>
		<input type="checkbox" id="mike" value="Mike" v-model="checkedNames">
		<label for="mike">Mike</label> <br> <span>Checked names:
			{{ checkedNames }}</span>
	</div>
</body>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/vue.js"></script>
<script>
	// 这是我们的Model
	var exampleData = {
		message : 'Hello World!'
	}

	// 创建一个 Vue 实例或 "ViewModel"
	// 它连接 View 与 Model
	new Vue({
		el : '#app',
		data : exampleData
	})

	var app2 = new Vue({
		el : '#app-2',
		data : {
			message : '页面加载于 ' + new Date().toLocaleString()
		}
	})
	//app2.message = '新消息'
	var app3 = new Vue({
		el : '#app-3',
		data : {
			seen : true
		}
	})
	app3.seen = false
	var app4 = new Vue({
		el : '#app-4',
		data : {
			todos : [
				{
					text : '学习 JavaScript'
				},
				{
					text : '学习 Vue'
				},
				{
					text : '整个牛项目'
				}
			]
		}
	})
	app4.todos.push({
		text : '新项目'
	})
	var app5 = new Vue({
		el : '#app-5',
		data : {
			message : 'Hello Vue.js!'
		},
		methods : {
			reverseMessage : function() {
				this.message = this.message.split('').reverse().join('')
			}
		}
	})
	var app6 = new Vue({
		el : '#app-6',
		data : {
			message : 'Hello Vue!'
		}
	})
	Vue.component('todo-item', {
		// todo-item 组件现在接受一个
		// "prop"，类似于一个自定义特性。
		// 这个 prop 名为 todo。
		props : [ 'todo' ],
		template : '<li>{{ todo.text }}</li>'
	})
	Vue.component('todo-item', {
		props : [ 'todo' ],
		template : '<li>{{ todo.text }}</li>'
	})

	var app7 = new Vue({
		el : '#app-7',
		data : {
			groceryList : [
				{
					id : 0,
					text : '蔬菜'
				},
				{
					id : 1,
					text : '奶酪'
				},
				{
					id : 2,
					text : '随便其它什么人吃的东西'
				}
			]
		}
	})
	var vm = new Vue({
		el : '#example',
		data : {
			message : 'Hello'
		},
		computed : {
			// 计算属性的 getter
			reversedMessage : function() {
				// `this` 指向 vm 实例
				return this.message.split('').reverse().join('')
			}
		},
		methods : {
			reversedMessage : function() {
				return this.message.split('').reverse().join('')
			}
		},
		computed : {
			now : function() {
				return Date.now()
			}
		}
	})
	var vm = new Vue({
		el : '#demo',
		data : {
			firstName : 'Foo',
			lastName : 'Bar',
			fullName : 'Foo Bar'
		},
		watch : {
			firstName : function(val) {
				this.fullName = val + ' ' + this.lastName
			},
			lastName : function(val) {
				this.fullName = this.firstName + ' ' + val
			}
		}
	})


	var watchExampleVM = new Vue({
		el : '#watch-example',
		data : {
			question : '',
			answer : 'I cannot give you an answer until you ask a question!'
		},
		watch : {
			// 如果 `question` 发生改变，这个函数就会运行
			question : function(newQuestion, oldQuestion) {
				this.answer = 'Waiting for you to stop typing...'
				this.debouncedGetAnswer()
			}
		},
		created : function() {
			// `_.debounce` 是一个通过 Lodash 限制操作频率的函数。
			// 在这个例子中，我们希望限制访问 yesno.wtf/api 的频率
			// AJAX 请求直到用户输入完毕才会发出。想要了解更多关于
			// `_.debounce` 函数 (及其近亲 `_.throttle`) 的知识，
			// 请参考：https://lodash.com/docs#debounce
			this.debouncedGetAnswer = _.debounce(this.getAnswer, 500)
		},
		methods : {
			getAnswer : function() {
				if (this.question.indexOf('?') === -1) {
					this.answer = 'Questions usually contain a question mark. ;-)'
					return
				}
				this.answer = 'Thinking...'
				var vm = this
				axios.get('https://yesno.wtf/api')
					.then(function(response) {
						vm.answer = _.capitalize(response.data.answer)
					})
					.catch(function(error) {
						vm.answer = 'Error! Could not reach the API. ' + error
					})
			}
		}
	})
	new Vue({
		el : '#example-3',
		data : {
			checkedNames : []
		}
	})
</script>
</html>