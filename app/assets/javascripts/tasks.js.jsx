
var Tasks = React.createClass({
    render(){


        return <div>{this.props.tasks.map((item) =>
            <p key={item.id}>
                <a href={'/tasks/' + item.id}>{item.body}</a>
            </p>
        )} </div>;
    }
});





