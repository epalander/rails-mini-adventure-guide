import React from "react";
import PropTypes from "prop-types";
import FaceIcon from "@material-ui/icons/Face";

class HelloWorld extends React.Component {
  render() {
    return (
      <React.Fragment>
        Greeting: {this.props.greeting}
        <FaceIcon />
      </React.Fragment>
    );
  }
}

HelloWorld.propTypes = {
  greeting: PropTypes.string,
};
export default HelloWorld;
