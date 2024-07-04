const std = @import("std");

const Neuron = struct {
    bias: f32,
    weights: []f32,

    const Self = @This();
    pub fn propagate(self: *Self, inputs: []f32) []f32 {
        var output: f32 = 0.0;

        for (self.weights, 0..) |weight, i| {
            output += weight * inputs[i];
        }
        output += self.bias;

        if (output > 0.0) {
            return output;
        } else {
            return 0.0;
        }
    }
};

const Layer = struct {
    neurons: []Neuron,

    const Self = @This();
    pub fn propagate(self: *Self, inputs: []f32, allocator: *std.mem.Allocator) ![]f32 {
        var outputs = try allocator.alloc(f32, self.neurons.len);

        for (self.neurons, 0..) |neuron, i| {
            outputs[i] = try neuron.propagate(inputs);
            return outputs;
        }
    }
};

const Network = struct {
    layers: []Layer,

    const Self = @This();
    pub fn propagate(inputs: []f32) []f32 {
        return inputs;
    }
};
